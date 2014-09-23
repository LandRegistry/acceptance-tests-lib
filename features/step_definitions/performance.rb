require 'timeout'
require 'open3'

Given(/^I want to run a performance$/) do

  # This variable prevents any functions being called to produce meta data
  $PERFROMANCETEST = true

  # Result hash for trasctions
  $results_transactions = Hash.new()
  # Result hash for scenarios
  $results_scenarios = Hash.new()

  # Result hash for transctions in a form dumpable for the transactions graph
  $results_transactions_graph = Hash.new()
  # Result hash for scenarios in a form dumpable for the transactions graph
  $results_scenarios_graph = Hash.new()

  # How many v_users are currently running
  $running_v_users = 0

  # V Users change over time, this will keep track every second
  $results_vusers = Hash.new()

  # How long the before one v user finishes and they restart
  $scriptdelaytime = 0

  # Start time of the test
  $starttime = Time.new.to_i

  # How many failures
  $total_failures = 0

  # an Array of error messages
  $error_log = []

  # Start the graph x axes
  $max_x = 3

  # Start a controller, this is a GUI to allow you to monitor the test.
  # This uses sinatra and is accessable by: http://localhost:4567
  controller_thread = Thread.new{controller}

  # Runs Cucumber to get a list of tests. This will be reworked in the future
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

  # This will use the cucumber call above to work out if the scenario you've enter
  # is valid and can be run.
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
  # Define the duration of the test
  $duration = duration.to_i * 60
end

Given(/^I ramp up (\d+) user every (\d+) seconds$/) do |rampup_users, rampup_time|
  # The space between each user starts up.
  $ramp_up_time = rampup_time.to_i
  # How many users to start up per every interval defined above.
  $ramp_up_users = rampup_users
end

When(/^I run the performance test$/) do

  # The duration needs adjusting to include the ramp up time
  # This will include the amount of users * interval
  $duration = $duration + ($amount_of_users * $ramp_up_time)

  # creates an array to manage the threads
  threads = Array.new()

  # We need to get a unique list of the performance test names
  $list_of_tests = Array.new()

  # This block of code below loops though each of the v users to get a unique
  # list of test file names
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

  # We need to know which test we're v user we're up to.
  $vuser_inc = 0

  # We now need to start each of the v users as seperate threads
  # This means each vuser can run indepedently
  for i in 0..($amount_of_users - 1)
    # Calls the loadtest() function
    threads.push(Thread.new{loadtest()})
  end

  # Whilst the v users are running, we need to keep track of what the v users are doing
  # This block of code below will keep a count of second how many v users are running
  cur_time = 0

  running = true

  # There is three ways of knowing if the performance testing is still running
  # if the variable running is true (this gets set to valse when $running_v_users goes above 0, meaning the test has started)
  # The current time is less than the start time plus the duration
  # #running_v_users is above 0

  while (((Time.new.to_i) < ($starttime + $duration)) || ($running_v_users > 0) || (running == true)) do

    # Increase current time by 1 (1 second)
    cur_time = cur_time + 1

    # $graph_time is the yavis max, as v users exit, this can go above the
    # duration, so this expands the yaxis
    $graph_time = $duration
    if (cur_time > $duration) then
      $graph_time = cur_time
    end

    # Build the $results_vusers with the current amount of running v users
    for i in 0..((Time.new.to_i - $starttime + 1))
      if ($results_vusers[i + 1].nil? == true) then
        $results_vusers[i + 1] = $running_v_users
      end
    end

    # If $running_v_users is above 0, set the value to true
    if ($running_v_users == 0) then
      running = false
    else
      running = true
    end

    # sleep for a second
  	sleep(1)

  end

  # Joining threads means the system will wait for them to finish. This means the v users stop
  for i in 0..($amount_of_users - 1)
     threads[i].join
  end

  # Once the performance test has finished the sinatra app stops,
  # this gets around that by visiting the page and producing a pdf output
  visit('http://localhost:4567')
  save_screenshot("performance-#{Time.new.to_i}.pdf")

end

Then(/^I expect less than (\d+) failures$/) do |failures|
  # Checks if the total failures is below the threadhold.
  assert_operator $total_failures, :<, failures.to_i, 'The failures weren\'t below the threshold'
end

Then(/^the scenarios response times were below:$/) do |table|
  # Loop through each of the scenarios to see if they were below the threshold
  table.raw.each do |value|
    if (value[0] != 'SCENARIO')
      # We need to get the average of the scenarios and then devide that by 1000 because they are in miliseconds
      response_time = ($results_scenarios[$features_hash[value[0]]].inject{ |sum, el| sum + el }.to_f / $results_scenarios[$features_hash[value[0]]].size) / 1000
      # Assert to see if the response time is below the threshold
      assert_operator response_time, :<, value[1].to_i, 'The average response time wasn\'t below the threshold (' + value[0] + ')'
    end
  end

end


#####
## Function: loadtest
## Inputs: None
## Outputs: None
## Description: This function should be called when a v user thread is created,
##              this will open the scripts in steps_definitions\performance
##              and run the v_action() in there.
#####
def loadtest()

  # Redirect $stdout (Console output) to nil

  # Workout the delay time of the script
	$scriptdelaytime = $scriptdelaytime + $ramp_up_time

  # Sleep for that delay time, so we can start ramping up users incrementally
	sleep $scriptdelaytime

  # Get which cucumber scenario by using the $vuser_inc variable.
  cucumber_scenario = $vuser_scenarios[$vuser_inc]
  # Increase this variable by 1 so the other scenarios can use it
  $vuser_inc = $vuser_inc + 1

    # convervate the cucumber scenario name, into the class name
    scenario_name = $running_scenarios_hash_name[cucumber_scenario].gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

    # create an instance of the class from the (step_defitions/performance) file
    script = Module.const_get(scenario_name).new

    # Increase the variable which keeps track of running virtual users
    $running_v_users = $running_v_users + 1

    iteration = 0

    # Loop through for the duration of the test, this will run the test each time it loops
  	while ((Time.new.to_i)  < ($starttime + $duration)) do

      iteration += 1

      # Works out the start time of the current test (iteration)
    	scriptstart_time = Time.now

      # We'll run the test in a try/except block to ensure it doesn't kill the thread
      begin
        # Call the threads action step
        script.v_action()

      rescue Exception=>e
        # If it fails, keep a log of why, then carry on

        error = {}
        error['error_message'] = e
        error['error_iteration'] = iteration
        error['error_script'] = cucumber_scenario


        $error_log << error

        $total_failures = $total_failures + 1
          $stdout.puts  e
      end

      # As the test has finished, work out the duration
    	script_duration = (Time.now - scriptstart_time) * 1000

      # If the duration is above the x axis current value, let's increase it
      if ((script_duration / 1000) > $max_x) then
        $max_x = (script_duration / 1000).ceil + 1
      end

      # If the current cucumber scenario have no results, lets define their arrays
      if ($results_scenarios[cucumber_scenario].nil?) then
        $results_scenarios[cucumber_scenario] = []
        $results_scenarios_graph[cucumber_scenario] = {}
      end

      # Add the duration of the test to an array so we can work our max/min/avg etc...
      $results_scenarios[cucumber_scenario] << script_duration

      # For each second we need to build up an average, so need to build up another array
      # based on the current time
      current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

      # If the array doesn't exist for the current time, then lets define it
      if($results_scenarios_graph[cucumber_scenario][current_time_id].nil? == true) then
        $results_scenarios_graph[cucumber_scenario][current_time_id] = Array.new()
      end

      # Add the value to the array
      $results_scenarios_graph[cucumber_scenario][current_time_id].push(script_duration)

      # Sleep a second between each scenario. This will need to be parametised soon
      sleep(1)

  	end
    # Once the test has finished, lets decrease the $running_v_users value
    $running_v_users = $running_v_users - 1

end



#####
## Function: start_traction
## Inputs: step_name (String)
## Outputs: current time (dateTime)
## Description: This is to get the time at a certain points to work out the
##              response time of certain parts of the load test
#####
def start_traction(step_name)

  scriptstart_time = Time.now

end

#####
## Function: start_traction
## Inputs: step_name (String)
## Outputs: current time (dateTime)
## Description: This is to get the time at a certain points to work out the
##              response time of certain parts of the load test
#####
def end_traction(step_name, start_time)

  # This uses the value from start_traction() and finds how long the test took.
  transaction_duration = (Time.now - start_time) * 1000

  # If the current transaction have no results, lets define their arrays
  if ($results_transactions[step_name].nil?) then
    $results_transactions[step_name] = []
    $results_transactions_graph[step_name] = {}
  end

  # Add the duration of the test to an array so we can work our max/min/avg etc...
  $results_transactions[step_name] << transaction_duration

  # For each second we need to build up an average, so need to build up another array
  # based on the current time
  current_time_id = $duration - (($starttime + $duration) - Time.new.to_i) + 1

  # If the array doesn't exist for the current time, then lets define it
  if($results_transactions_graph[step_name][current_time_id].nil? == true) then
    $results_transactions_graph[step_name][current_time_id] = Array.new()
  end

  # Add the value to the array
  $results_transactions_graph[step_name][current_time_id].push(transaction_duration)

end

#####
## Function: http_get
## Inputs: curl (Curl::Easy Instance) data (Hash of headers) url (String of the url)
## Outputs: current time (dateTime)
## Description: Performs a http get command for the user specified
#####
def http_get(curl, data, url)

  #puts 'GET: ' + url

  # Define the url we want to hit
  curl.url=url

  # Specify the headers we want to hit
  curl.headers = data['header']

  # perform the call
  curl.http_get

  # Set headers to nil so none get reused elsewhere
  curl.headers = nil

  # return the curl object
  return curl
end

#####
## Function: http_post
## Inputs: curl (Curl::Easy Instance) data (Hash of headers and posts) url (String of the url)
## Outputs: current time (dateTime)
## Description: Performs a http get command for the user specified
#####
def http_post(curl, data, url)

  # Define the post data
  data2 = ''

  # Loop through the data["post_data"] passed in to build up the post data string
  data["post_data"].each do |key, value|
    if (data2 != '') then
      data2 = data2 + '&'
    end
    # If the value is null we don't just want it to look like: item=
    if (value.nil?) then
      data2 = data2 + CGI::escape(key.to_s) + '='
    else
      data2 = data2 + CGI::escape(key.to_s) + '=' + CGI::escape(value.to_s)
    end
  end

  # Define the url we want to hit
  curl.url = url
  # Specify the headers we want to hit
  curl.headers = data['header']

  # perform the call
  curl.post(data2)

  curl.headers = nil

  # Set headers to nil so none get reused elsewhere
  curl.headers = nil

  # return the curl object
  return curl

end

#####
## Function: assert_http_status
## Inputs: curl (Curl::Easy Instance) status (expected http status code)
## Outputs: current time (dateTime)
## Description: Performs a http get command for the user specified
#####
def assert_http_status(curl, status)

  # If the status doesn't match, then raise an exception
  if (curl.response_code != status) then
    raise  curl.url + ': Expected response of ' + status.to_s + ' but was ' + curl.response_code.to_s
  end
end


#####
## Function: controller
## Inputs: None
## Outputs: None
## Description: This is the controller thread for running the sinatra app, monitoring the run
#####
def controller()

  # Create a Sinatra isntance
  $sinatra_instance = Sinatra.new()

  # Get a localhost/data url defined (used by ajax)
  $sinatra_instance.get '/data' do

    # we need to turn the data object into a json response at the end
    data = {}

    # This is the array of data for each scenario for the graph
    data['graph_data'] = []

    # The array for the erros
    data['error_log'] = $error_log

    # Define the graph data objects
    for i in 0..10
      data['graph_data'][i] = []
    end

    # Work out the xmax and ymax
    data['graph_xmax'] = (($graph_time || 0) * 1.05).ceil.to_s
    data['graph_ymax'] = (($amount_of_users || 0) * 1.2).ceil.to_s

    # Sets the graph data for [0] (vusers) to 0, stops an error
    data['graph_data'][0][0] = 0

    # Loops through each second to get the graph data
    for i in 0..((Time.new.to_i - $starttime ))

      # The [0] is for v users
      data['graph_data'][0][i] = $results_vusers[i + 1]

      num = 0
      # Anthing above [0] is for the running tests
      $results_scenarios_graph.each do |key, results2|
        num = num + 1
        if (results2[i + 1].nil? == false) then

          sum = 0
          results2[i + 1].each { |a| sum+=a }

          # Add the results to the json object
          data['graph_data'][num][i] = ((sum / results2[i + 1].size.to_f) / 1000).round(2)
          data['graph_y2max'] = ($max_x * 1.1)
        end
      end
    end



    # Define the objects for the overview of the cucumber scenarios (table below graph)
    data['graph_details_name'] = []
    data['graph_details_min'] = []
    data['graph_details_max'] = []
    data['graph_details_avg'] = []

    data['graph_details_name'][0] = 'Vusers'

    # If the data exists then use it, otherwise set it to 0
    if (!data['graph_data'].nil?) then
      data['graph_details_min'][0] = data['graph_data'][0].min.round(2)
      data['graph_details_max'][0] = data['graph_data'][0].max.round(2)
      data['graph_details_avg'][0] =  (data['graph_data'][0].inject{ |sum, el| sum + el }.to_f / data['graph_data'][0].size).round(2)
    else
      data['graph_details_min'][0] = 0
      data['graph_details_max'][0] = 0
      data['graph_details_avg'][0] = 0
    end

    # This is the same as above, but for tests, not the vusers
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


    # Print the output as a json string
    return data.to_json
  end

  # Get a localhost url defined (main page)
  $sinatra_instance.get '/' do

    erb :'index.html'

  end

  # run sinatra on the default url/port
  $sinatra_instance.run!

end
