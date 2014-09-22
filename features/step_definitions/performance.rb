require 'timeout'
require 'open3'

Given(/^I want to run a performance$/) do

  $PERFROMANCETEST = true

  $results = Array.new()

  $results2 = Hash.new()

  $results_transactions = Hash.new()
  $results_scenarios = Hash.new()

  $results_transactions_graph = Hash.new()
  $results_scenarios_graph = Hash.new()

  $running_v_users = 0

  $results_vusers = Hash.new()

  $scriptdelaytime = 0

  $starttime = Time.new.to_i

  $total_failures = 0

  $error_log = []

  $max_x = 3

  controller_thread = Thread.new{controller}


  args = []
  args << '--dry-run'
  args << '--format'
  args << 'json'

  @in = StringIO.new
  @out = StringIO.new
  @err = StringIO.new

  begin
    cuke = Cucumber::Cli::Main.new(args, @in, @out, @err).execute!
  rescue Exception=>e
    # Do nothing!
  end

  $features_hash = {}

  $scenario_steps = {}

  JSON.parse(@out.string).each do |features|
    features['elements'].each do |scenarios|
      $features_hash[scenarios['name'].to_s] = features['uri'].to_s + ':' + scenarios['line'].to_s
      $scenario_steps[features['uri'].to_s + ':' + scenarios['line'].to_s] = []
    end
  end

end

Given(/^I have the following scenarios$/) do |table|

  $running_scenarios_hash = {}

  $running_scenarios_hash_name = {}

  $amount_of_users = 0

  $vuser_scenarios = []

  table.raw.each do |value|
    if (!$features_hash[value[0]].nil?)
      $amount_of_users = $amount_of_users + value[1].to_i
      $running_scenarios_hash[$features_hash[value[0]]] = value[1].to_i
      $running_scenarios_hash_name[$features_hash[value[0]]] = value[0]

      for i in 0..value[1].to_i - 1
        $vuser_scenarios << $features_hash[value[0]]
      end

      require_relative 'performance/' + value[0].gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize.downcase

    end
  end

  $vuser_scenarios.shuffle

end

Given(/^I run for (\d+) minute(s|)$/) do |duration, word|
  $duration = duration.to_i * 60
end

Given(/^I ramp up (\d+) user every (\d+) seconds$/) do |rampup_users, rampup_time|
  $ramp_up_time = rampup_time.to_i
  $ramp_up_users = rampup_users
end

When(/^I run the performance test$/) do

  $duration = $duration + ($amount_of_users * $ramp_up_time)

  #puts 'Start Time: ' + $starttime.to_s

  threads = Array.new()

  $list_of_tests = Array.new()



  $vuser_scenarios.each do |value|
    found = false
    for i in 0..($list_of_tests.count - 1)
      if ($list_of_tests[i] == value) then
        found = true
      end
    end
    if (found == false) then
      $list_of_tests << value
    end
  end

  $vuser_inc = 0

  for i in 0..($amount_of_users - 1)

    threads.push(Thread.new{loadtest()})

  end


  cur_time = 0

  running = true

  while (((Time.new.to_i) < ($starttime + $duration)) || ($running_v_users > 0) || (running == true)) do

    cur_time = cur_time + 1

    $graph_time = $duration
    if (cur_time > $duration) then
      $graph_time = cur_time
    end

    for i in 0..((Time.new.to_i - $starttime + 1))

      if ($results_vusers[i + 1].nil? == true) then

        $results_vusers[i + 1] = $running_v_users

      end

    end

    if ($running_v_users == 0) then
      running = false
    else
      running = true
    end

  	sleep(1)

  end





  for i in 0..($amount_of_users - 1)
     threads[i].join
  end

  visit('http://localhost:4567')

  save_screenshot("performance-#{Time.new.to_i}.pdf")

end

Then(/^I expect less than (\d+) failures$/) do |failures|

  assert_operator $total_failures, :<, failures.to_i, 'The failures weren\'t below the threshold'

end

Then(/^the scenarios response times were below:$/) do |table|

  table.raw.each do |value|
    if (value[0] != 'SCENARIO')

      response_time = ($results_scenarios[$features_hash[value[0]]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[$features_hash[value[0]]].size) / 1000

      assert_operator response_time, :<, value[1].to_i, 'The average response time wasn\'t below the threshold (' + value[0] + ')'
    end
  end

end




def loadtest()

  $stdout = StringIO.new

	$scriptdelaytime = $scriptdelaytime + $ramp_up_time

	sleep $scriptdelaytime

  cucumber_scenario = $vuser_scenarios[$vuser_inc]
  $vuser_inc = $vuser_inc + 1

#  puts cucumber_scenario

    scenario_name = $running_scenarios_hash_name[cucumber_scenario].gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

    script = Module.const_get(scenario_name).new

    $running_v_users = $running_v_users + 1

  	while ((Time.new.to_i)  < ($starttime + $duration)) do

    	scriptstart_time = Time.now

      begin
        script.v_action()

      rescue Exception=>e

        $error_log << e
        $total_failures = $total_failures + 1
          $stdout.puts  e
      end

    	script_duration = (Time.now - scriptstart_time) * 1000

      if ((script_duration / 1000) > $max_x) then
        $max_x = (script_duration / 1000).ceil + 1
      end

      if ($results_scenarios[cucumber_scenario].nil?) then
        $results_scenarios[cucumber_scenario] = []
        $results_scenarios_graph[cucumber_scenario] = {}
      end

      $results_scenarios[cucumber_scenario] << script_duration

      current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

      if($results_scenarios_graph[cucumber_scenario][current_time_id].nil? == true) then
        $results_scenarios_graph[cucumber_scenario][current_time_id] = Array.new()
      end

      $results_scenarios_graph[cucumber_scenario][current_time_id].push(script_duration)

      sleep(1)

  	end

    $running_v_users = $running_v_users - 1

end




def start_traction(step_name)

  scriptstart_time = Time.now

end


def end_traction(step_name, start_time)

  transaction_duration = (Time.now - start_time) * 1000

  if ($results_transactions[step_name].nil?) then
    $results_transactions[step_name] = []
    $results_transactions_graph[step_name] = {}
  end

  $results_transactions[step_name] << transaction_duration

  current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

  if($results_transactions_graph[step_name][current_time_id].nil? == true) then
    $results_transactions_graph[step_name][current_time_id] = Array.new()
  end

  $results_transactions_graph[step_name][current_time_id].push(transaction_duration)

end

def http_get(curl, data, url)

  #puts 'GET: ' + url

  curl.url=url

  curl.headers = data['header']
  curl.perform

  curl.headers = nil
  #puts curl.header_str


  return curl
end

def http_post(curl, data, url)

#  puts 'POST: ' + url

  data2 = ''

  data["post_data"].each do |key, value|
    if (data2 != '') then
      data2 = data2 + '&'
    end

    if (value.nil?) then
      data2 = data2 + CGI::escape(key.to_s) + '='
    else
      data2 = data2 + CGI::escape(key.to_s) + '=' + CGI::escape(value.to_s)
    end
  end


  curl.url = url
  curl.headers = data['header']

  curl.headers = nil

  return curl

end


def assert_http_status(curl, status)

  if (curl.response_code != status) then
    raise  curl.url + ': Expected response of ' + status.to_s + ' but was ' + curl.response_code.to_s
  end
end



def controller()
#  $stdout.puts 'controller '

  $sinatra_instance.get '/data' do

    data = {}

    data['graph_data'] = []



    data['error_log'] = $error_log

    for i in 0..10

      data['graph_data'][i] = []

    end


    data['graph_xmax'] = (($graph_time || 0) * 1.05).ceil.to_s
    data['graph_ymax'] = (($amount_of_users || 0) * 1.2).ceil.to_s
    data['graph_ymax'] = (($amount_of_users || 0) * 1.2).ceil.to_s

    data['graph_data'][0][0] = 0


    for i in 0..((Time.new.to_i - $starttime ))

      data['graph_data'][0][i] = $results_vusers[i + 1]

      num = 0
      $results_scenarios_graph.each do |key, results2|
        num = num + 1
        if (results2[i + 1].nil? == false) then

          sum = 0
          results2[i + 1].each { |a| sum+=a }

          data['graph_data'][num][i] = ((sum / results2[i + 1].size.to_f) / 1000).round(2)
          data['graph_y2max'] = ($max_x * 1.1)
        end
      end
    end




    data['graph_details_name'] = []
    data['graph_details_min'] = []
    data['graph_details_max'] = []
    data['graph_details_avg'] = []

    data['graph_details_name'][0] = 'Vusers'

    if (!data['graph_data'].nil?) then
      data['graph_details_min'][0] = data['graph_data'][0].min.round(2)
      data['graph_details_max'][0] = data['graph_data'][0].max.round(2)
      data['graph_details_avg'][0] =  (data['graph_data'][0].inject{ |sum, el| sum + el }.to_f / data['graph_data'][0].size).round(2)
    else
      data['graph_details_min'][0] = 0
      data['graph_details_max'][0] = 0
      data['graph_details_avg'][0] = 0
      end

    for i in 0..($list_of_tests.count - 1)

      data['graph_details_name'][i + 1] = $list_of_tests[i]

      if (!$results_scenarios[$list_of_tests[i]].nil?) then

        data['graph_details_min'][i + 1] = ($results_scenarios[$list_of_tests[i]].min / 1000).round(2)
        data['graph_details_max'][i + 1] = ($results_scenarios[$list_of_tests[i]].max / 1000).round(2)
        data['graph_details_avg'][i + 1] = (($results_scenarios[$list_of_tests[i]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[$list_of_tests[i]].size) / 1000).round(2)

      else

        data['graph_details_min'][i + 1] = 0
        data['graph_details_max'][i + 1] = 0
        data['graph_details_avg'][i + 1] = 0

      end

    end



    return data.to_json
  end

  $sinatra_instance.get '/' do

    erb :'index.html'

  end

  $sinatra_instance.run!

end
