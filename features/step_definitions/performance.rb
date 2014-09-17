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
    end
  end

  $vuser_scenarios.shuffle

  puts $running_scenarios_hash
end

Given(/^I run for (\d+) minutes$/) do |duration|
  $duration = duration.to_i
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

  $starttime = Time.new.to_i

  $total_failures = 0

  puts 'Start Time: ' + $starttime.to_s



  #Thread.abort_on_exception = true

  threads = Array.new()

  #threads.push(Thread.new{loadtest('features/citizen/view_property_details.feature:4')})

  for i in 0..($amount_of_users - 1)

    threads.push(Thread.new{loadtest($vuser_scenarios[i])})
    sleep($ramp_up_time)
  end

  for i in 0..($amount_of_users - 1)
     threads[i].join
  end


end

Then(/^I expect less than (\d+) failures$/) do |failures|


  for i in 0..($duration - 1)

  	if ($results2[i + 1].nil? == false) then

  		sum = 0
  		$results2[i + 1].each { |a| sum+=a }

  		puts 'graph_data[' + i.to_s + '] = "' + (sum / $results2[i + 1].size.to_f).round(2).to_s + '" ' + "\n"

  	end

  end

  sum = 0
  $results.each { |a| sum+=a }

  puts 'Max Time: ' + $results.max.to_s
  puts 'Min Time: ' + $results.min.to_s
  puts 'Avg Time: ' + (sum / $results.size.to_f).to_s

  puts $results2

  puts $results_transactions
  puts $results_scenarios

  assert_operator $total_failures, :<, failures.to_i, 'The failures weren\'t below the threshold'


end

Then(/^the scenarios response times were below:$/) do |table|


  table.raw.each do |value|
    if (!$features_hash[value[0]].nil?)
      $amount_of_users = $amount_of_users + value[1].to_i
      $running_scenarios_hash[$features_hash[value[0]]] = value[1].to_i
      for i in 0..value[1].to_i - 1
        $vuser_scenarios << $features_hash[value[0]]
      end
    end
  end


  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end




def loadtest(cucumber_scenario)

  $stdout.puts cucumber_scenario
  puts cucumber_scenario

    scenario_name = $running_scenarios_hash_name[cucumber_scenario].gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

    require_relative 'performance/' + scenario_name.downcase
    script = Module.const_get(scenario_name).new

  	while ((Time.new.to_i)  < ($starttime + $duration)) do

    	scriptstart_time = Time.new.to_i

      begin
        $stdout.puts 'dsadsa'
        script.v_action()

      rescue Exception=>e
        $total_failures = $total_failures + 1
      end


    	script_duration = Time.new.to_i - scriptstart_time

      if ($results_scenarios[cucumber_scenario].nil?) then

        $results_scenarios[cucumber_scenario] = {}
      end

      current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

      if($results_scenarios[cucumber_scenario][current_time_id].nil? == true) then

        $results_scenarios[cucumber_scenario][current_time_id] = Array.new()

      end

      $results_scenarios[cucumber_scenario][current_time_id].push(script_duration)

      sleep(1)
      puts $results2

  	end

end




def start_traction(step_name)

  scriptstart_time = Time.new.to_i

end


def end_traction(step_name, start_time)

  transaction_duration = Time.new.to_i - start_time

  if ($results_transactions[step_name].nil?) then

    $results_transactions[step_name] = {}
  end

  current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

  if($results_transactions[step_name][current_time_id].nil? == true) then

    $results_transactions[step_name][current_time_id] = Array.new()

  end

  $results_transactions[step_name][current_time_id].push(transaction_duration)

end

def http_get(url)

  $stdout.puts url

	uri = URI.parse(url)

	http = Net::HTTP.new(uri.host, uri.port)

	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)

end

def http_post(url, data)

  $stdout.puts url

  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

end
