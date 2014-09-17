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
      scenarios['steps'].each do |steps|

        #puts steps
        puts 'a' + steps['keyword'].strip + 'a'
        puts 'a1' + steps['keyword'].strip + 'a1'
        if (steps['keyword'].strip.to_s != 'And') then
          $steptype = steps['keyword'].strip.to_s
        end
        puts 'a2' + $steptype + 'a2'



        if ($steptype != 'Then')
          puts 'b' + steps['keyword'].strip + 'b' + $steptype + 'b'
          $scenario_steps[features['uri'].to_s + ':' + scenarios['line'].to_s] << steps['name']
        end

      end
    end
  end




end

Given(/^I have the following scenarios$/) do |table|

  $running_scenarios_hash = {}

  $amount_of_users = 0

  $vuser_scenarios = []

  table.raw.each do |value|
    if (!$features_hash[value[0]].nil?)
      $amount_of_users = $amount_of_users + value[1].to_i
      $running_scenarios_hash[$features_hash[value[0]]] = value[1].to_i
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

  $starttime = Time.new.to_i

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

Then(/^I expect less than (\d+) failures$/) do |arg1|


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








  pending # express the regexp above with the code you wish you had
end

Then(/^the scenarios response times were below:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end




def loadtest(cucumber_scenario)
$stdout.puts cucumber_scenario
  puts cucumber_scenario

### Configures Capybara to use Xpath selectors and use poltergeist driver
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

### Set the options for poltergeist to use
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :js_errors => false)
end

#This removes the referer for the map tiles to be returned
page.driver.add_header("Referer", "", permanent: true)

	while ((Time.new.to_i)  < ($starttime + $duration)) do

    status = Timeout::timeout(30) {

  		scriptstart_time = Time.new.to_i
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :js_errors => false)
end
Capybara::Session.new(cucumber_scenario)

        @in = StringIO.new
        @out = StringIO.new
        @err = StringIO.new


        args = []
        args << '-r'
        args << 'features'
        args << '--format'
        args << 'json'
        args << cucumber_scenario
        $stdout.puts 'a'



          #step step_name
            begin
              Capybara.session_name = cucumber_scenario


            #  $scenario_steps[cucumber_scenario].each do |step_name|
            #    status = Timeout::timeout(7) {
            #      $stdout.puts step_name

              #    $stdout.puts step step_name
              #  }
              #end
              #
                  stdin, stdout, stderr = Open3.popen3('cucumber -r features ' + cucumber_scenario)

                  puts stdout.readlines

            # system('cucumber -r features ' + cucumber_scenario)
          #  Capybara.session_name = cucumber_scenario

          #  cuke2 = Cucumber::Cli::Main.new(args, @in, @out, @err).execute!
            #  Capybara.session_name = cucumber_scenario
            #  run_test(cucumber_scenario)
            rescue Exception=>e

              $stdout.puts @out.string
              $stdout.puts @err.string


            end

            $stdout.puts @out.string
              $stdout.puts @err.string



        #  Process.wait


      $stdout.puts @out.string
      $stdout.puts @err.string

  		script_duration = Time.new.to_i - scriptstart_time

  		if($results2[$duration - (($starttime + $duration) - Time.new.to_i) + 1].nil? == true) then

  			$results2[$duration - (($starttime + $duration) - Time.new.to_i) + 1] = Array.new()

  		end

      $results.push(script_duration)
  		$results2[$duration - (($starttime + $duration) - Time.new.to_i) + 1].push(script_duration)

      sleep(1)
      puts $results2

    }

	end

end




def run_test(cucumber_scenario)

  @in = StringIO.new
  @out = StringIO.new
  @err = StringIO.new

  args = []
  args << '-r'
  args << 'features'
  args << '--format'
  args << 'json'
  args << cucumber_scenario

  cuke2 = Cucumber::Cli::Main.new(args, @in, @out, @err).execute!

  return cuke2, @in, @out, @err

end
