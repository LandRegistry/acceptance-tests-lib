

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
   step_name = scenario.steps.to_a[$step].name
   $step = $step + 1


  perf_file_name = 'features/step_definitions/performance/' + scenario.name.gsub(/ /, '_') + '.rb'

  if (!File.file?(perf_file_name))

    file_structure = %{

      def v_init

        #v_init end
      end

      def v_action

        #v_action end
      end

      def v_end

        #v_end end
      end

    }

    File.open(perf_file_name, 'w') { |file| file.write(file_structure) }


  end
    if (page.driver.network_traffic.to_a.count > 0) then

    v_action_text = %{

        start_traction("#{step_name}")
        #v_action end
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', v_action_text)


    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


      page.driver.network_traffic.each do |request|
        begin


          if (request.method == 'POST')

            v_action_text = %{
                  http_post("#{request.url}", "#{Base64.decode64(request.data)}")
                #v_action end
            }



          else

            v_action_text = %{
                  http_get("#{request.url}")
                #v_action end
            }

          end

          puts v_action_text


          file_text = File.read(perf_file_name)
          file_text_mod = file_text.gsub('#v_action end', v_action_text)


          open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


        rescue

        end
      end

    v_action_text = %{
        end_traction("#{step_name}")

        #v_action end
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', v_action_text)


    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }



  end

  page.driver.clear_network_traffic


end
