require 'timeout'
require 'open3'

Given(/^I want to run a performance$/) do

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

  $max_x = 3

  puts 'Start Time: ' + $starttime.to_s

  threads = Array.new()

  list_of_tests = Array.new()



  $vuser_scenarios.each do |value|
    found = false
    for i in 0..(list_of_tests.count - 1)
      if (list_of_tests[i] == value) then
        found = true
      end
    end
    if (found == false) then
      list_of_tests << value
    end
  end

  for i in 0..($amount_of_users - 1)

    threads.push(Thread.new{loadtest($vuser_scenarios[i])})

  end


  File.open('graph/results.js', 'w') { |file| file.write('') }

  cur_time = 0

  running = true

  while (((Time.new.to_i) < ($starttime + $duration)) || ($running_v_users > 0) || (running == true)) do

    cur_time = cur_time + 1

    graph_time = $duration
    if (cur_time > $duration) then
      graph_time = cur_time
    end

  	logfile = ''

    for i in 1..10

      logfile  = logfile + "var graph_data#{i} = []; \n"

    end

  	logfile = logfile + "var graph_xmax = " + (graph_time * 1.05).ceil.to_s + "; \n"
  	logfile  = logfile + "var graph_ymax = 1; \n"
  	logfile  = logfile + "var graph_ymax = " + ($amount_of_users * 1.2).ceil.to_s + "; \n"
  	logfile  = logfile + "graph_data1[0] = 0; \n"

  	for i in 0..((Time.new.to_i - $starttime + 1))

  		if ($results_vusers[i + 1].nil? == true) then

  			$results_vusers[i + 1] = $running_v_users

  		end

  		logfile  = logfile + 'graph_data1[' + i.to_s + '] = "' + $results_vusers[i + 1].to_s + '" ' + ";\n"


      num = 1
      $results_scenarios_graph.each do |key, results2|
        num = num + 1
    		if (results2[i + 1].nil? == false) then

    			sum = 0
    			results2[i + 1].each { |a| sum+=a }

    			logfile  = logfile + 'graph_data' + num.to_s + '[' + i.to_s + '] = "' + (sum / results2[i + 1].size.to_f).round(2).to_s + '" ' + ";\n"
    			logfile  = logfile + "var graph_y2max = " + ($max_x * 1.1).ceil.to_s + " \n"
    		end

      end

  	end

    logfile  = logfile + "var graph_details_name = []; \n"
    logfile  = logfile + "var graph_details_min = []; \n"
    logfile  = logfile + "var graph_details_max = []; \n"
    logfile  = logfile + "var graph_details_avg = []; \n"

    for i in 0..(list_of_tests.count - 1)


      logfile  = logfile + "graph_details_name[#{i}] = '#{list_of_tests[i]}' \n"

      if (!$results_scenarios[list_of_tests[i]].nil?) then

        logfile  = logfile + "graph_details_max[#{i}] = '#{$results_scenarios[list_of_tests[i]].max}' \n"
        logfile  = logfile + "graph_details_min[#{i}] = '#{$results_scenarios[list_of_tests[i]].min}' \n"
        logfile  = logfile + "graph_details_avg[#{i}] = '#{($results_scenarios[list_of_tests[i]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[list_of_tests[i]].size)}' \n"

      else

        logfile  = logfile + "graph_details_max[#{i}] = '0' \n"
        logfile  = logfile + "graph_details_min[#{i}] = '0' \n"
        logfile  = logfile + "graph_details_avg[#{i}] = '0' \n"

      end

    end







          if ($running_v_users == 0) then
              running = false
          else
              running = true
          end

  	File.open('graph/results.js', 'w') { |file| file.write(logfile) }

  	sleep(1)

  end






  for i in 0..($amount_of_users - 1)
     threads[i].join
  end


end

Then(/^I expect less than (\d+) failures$/) do |failures|

  assert_operator $total_failures, :<, failures.to_i, 'The failures weren\'t below the threshold'

end

Then(/^the scenarios response times were below:$/) do |table|

  table.raw.each do |value|
    if (value[0] != 'SCENARIO')

      puts value[0]
      puts value[1]
      puts $features_hash[value[0]]

      puts value[0] + ' Actual Average: ' + ($results_scenarios[$features_hash[value[0]]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[$features_hash[value[0]]].size).to_s

      assert_operator ($results_scenarios[$features_hash[value[0]]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[$features_hash[value[0]]].size), :<, value[1].to_i, 'The average response time wasn\'t below the threshold'
    end
  end

end




def loadtest(cucumber_scenario)

	$scriptdelaytime = $scriptdelaytime + $ramp_up_time

	sleep $scriptdelaytime


  $stdout.puts cucumber_scenario
  puts cucumber_scenario

    scenario_name = $running_scenarios_hash_name[cucumber_scenario].gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

    script = Module.const_get(scenario_name).new

    $running_v_users = $running_v_users + 1

  	while ((Time.new.to_i)  < ($starttime + $duration)) do

    	scriptstart_time = Time.new.to_i

      begin
        $stdout.puts 'dsadsa'
        script.v_action()

      rescue Exception=>e
        $total_failures = $total_failures + 1
          $stdout.puts  e
      end

    	script_duration = Time.new.to_i - scriptstart_time

      if (script_duration > $max_x) then
        $max_x = script_duration
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

  scriptstart_time = Time.new.to_i

end


def end_traction(step_name, start_time)

  transaction_duration = Time.new.to_i - start_time

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

  puts 'GET: ' + url

  curl.url=url

  curl.headers = data['header']
  curl.perform

  curl.headers = nil
  #puts curl.header_str


  return curl.response_code
end

def http_post(curl, data, url, data2)

  puts 'POST: ' + url

  curl.max_redirects =1
  curl.url = url
#  curl.verbose = true
  curl.headers = data['header']
  puts curl.http_post(data2)

  curl.headers = nil


  return curl.response_code

end


def assert_http_status(curl, status)

  if (curl != status) then
    $total_failures = $total_failures + 1
  #  $stdout.puts 'Expected response of ' + status.to_s + ' but was ' + curl.to_s


  end
  $stdout.puts 'Expected response of ' + status.to_s + ' but was ' + curl.to_s
end
