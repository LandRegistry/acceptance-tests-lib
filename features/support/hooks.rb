

Before do | scenario |
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize($http_auth_name, $http_auth_password)
  end
  $log_start_time = (Time.now.to_f * 1000).to_i

  if (ENV['WEBDRIVER'] != 'Firefox') then
    page.driver.add_header("Referer", "", permanent: true)
  end
  page.driver.clear_network_traffic

  $step = 0
end

After do | scenario |

  if (scenario.failed?)
      save_screenshot("sshot-#{Time.new.to_i}.png", :full => true)
  end

end


AfterStep do | scenario |
   step_name = scenario.steps.to_a[$step].name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize
   scenario_name  = scenario.name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize
   $step = $step + 1
  if (page.driver.network_traffic.to_a.count > 0) then

    perf_file_name = 'features/step_definitions/performance/' + scenario_name.downcase + '.rb'

    if (!File.file?(perf_file_name))

      file_structure = %{

        class #{scenario_name}

          def initialize()

          end

          def v_init()


            #v_init end
          end

          def v_action()
@curl = Curl::Easy.new
@curl.follow_location = true
@curl.enable_cookies = true
            #v_action end
          end

          def v_end()

            #v_end end
          end

        end

      }

      File.open(perf_file_name, 'w') { |file| file.write(file_structure) }


    end


    v_action_text = %{

        trans_time = start_traction("#{step_name}")
        #v_action end
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', v_action_text)
    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

      prevredirect = '';
      page.driver.network_traffic.each do |request|

          puts request.response_parts[0].redirect_url
          begin




if (prevredirect != '302') then


v_action_text = %{
      data = {}
    #v_action end
}
file_text = File.read(perf_file_name)
file_text_mod = file_text.gsub('#v_action end', v_action_text)
open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }



if (request.headers.count > 0) then

  v_action_text = %{
        data["header"] = {}
      #v_action end
  }

  file_text = File.read(perf_file_name)
  file_text_mod = file_text.gsub('#v_action end', v_action_text)

  open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }



  request.headers.each do |value|

      puts value
      v_action_text = %{
            data["header"]["#{value['name']}"] = "#{value['value']}"
          #v_action end
      }

      file_text = File.read(perf_file_name)
      file_text_mod = file_text.gsub('#v_action end', v_action_text)

      open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


  end

end

  if (request.method == 'POST')

    v_action_text = %{
          response = http_post(@curl, data, "#{request.url}", "#{Base64.decode64(request.data)}")
        #v_action end
    }



  else

    v_action_text = %{
          response = http_get(@curl, data, "#{request.url}")
        #v_action end
    }

  end

  file_text = File.read(perf_file_name)
  file_text_mod = file_text.gsub('#v_action end', v_action_text)
  open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

end
puts request.response_parts[request.response_parts.count -1].status
puts request.response_parts[0].status

if (request.method != 'POST')

  if (request.response_parts[request.response_parts.count - 1].status.to_s != '302') then

    puts 'aaaaaa' + request.response_parts[request.response_parts.count - 1].status.to_s + 'aaaaa'
    v_action_text = %{
    assert_http_status(response, #{request.response_parts[request.response_parts.count -1].status})
    #v_action end
    }


    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', v_action_text)
    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

  end

end

          rescue




      end

      prevredirect = request.response_parts[request.response_parts.count - 1].status.to_s


    end

    v_action_text = %{
        end_traction("#{step_name}", trans_time)

        #v_action end
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', v_action_text)

    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

  end

  page.driver.clear_network_traffic


end
