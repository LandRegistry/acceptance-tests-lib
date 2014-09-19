

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

  $function_call_name = []
  $function_call_data = []
  $function_call_start = 0

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
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', '          ' + v_action_text.strip + "\n\n" + '#v_action temp end')
    file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

    if ($function_call_name.count > 0) then

      for i in $function_call_start..$function_call_name.count - 1

        v_action_text = %{

            genData#{i} = #{$function_call_name[i]}()
        }

        file_text = File.read(perf_file_name)
        file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n\n" + '#v_action temp end')
        file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
        open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

      end

      $function_call_start = $function_call_name.count

    end


      prevredirect = '';
      page.driver.network_traffic.each do |request|

        if (!request.url.include? 'data:application') then

          if (prevredirect == '') then

            puts request.response_parts[0].redirect_url


              v_action_text = %{
                    data = {}
              }

            file_text = File.read(perf_file_name)
            file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
            file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
            open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

            v_action_text = %{
                  data["header"] = {}
            }

            file_text = File.read(perf_file_name)
            file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
            file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
            open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }



            if (request.headers.count > 0) then

              request.headers.each do |value|
                  if (value['name'] != 'Content-Length') then

                    v_action_text = %{
                          data["header"]["#{value['name']}"] = "#{value['value']}"
                    }

                    file_text = File.read(perf_file_name)
                    file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
                    file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
                    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


                end

              end

            end

            if (request.method == 'POST')
              data_str = Base64.decode64(request.data)
              data_str_and = data_str.split('&')

              v_action_text = %{
                    data["post_data"] = {}
              }

              file_text = File.read(perf_file_name)
              file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
              file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
              open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


              data_str_and.each do |elements|
                data_str_keyvalue = elements.split('=')
                puts data_str_keyvalue
                post_key = CGI::unescape(data_str_keyvalue[0])

                if (data_str_keyvalue[1].nil?) then
                  data_str_keyvalue[1] = ''
                end

                post_value = '"' + CGI::unescape(data_str_keyvalue[1]).gsub('"', '\"') + '"'

                for i in 0..$function_call_data.count - 1

                    $function_call_data[i].each do |data_key, data_value|
                      if (CGI::unescape(data_str_keyvalue[1]).to_s == data_value.to_s) then
                        post_value = "genData#{i}[\"#{data_key.to_s}\"]"
                      #  puts data_key.to_s + ' - ' + data_value.to_s
                      end
                    end

                end


                v_action_text = %{
                      data["post_data"]["#{post_key}"] = #{post_value}
                }


                file_text = File.read(perf_file_name)
                file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
                file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
                open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

              end

              #v_action_text = %{
              #      response = http_post(@curl, data, "#{request.url}", "#{Base64.decode64(request.data)}")
              #}
              v_action_text = %{
                    response = http_post(@curl, data, "#{request.url}")
              }

            else

              v_action_text = %{
                    response = http_get(@curl, data, "#{request.url}")
              }

            end

            file_text = File.read(perf_file_name)
            file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
            file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
            open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

          end


          if (request.response_parts[request.response_parts.count - 1].redirect_url.to_s == '') then

            v_action_text = %{
            assert_http_status(response, #{request.response_parts[request.response_parts.count -1].status})
            }

            file_text = File.read(perf_file_name)
            file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n\n" + '#v_action temp end')
            file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
            open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


          end

      end

      prevredirect = request.response_parts[request.response_parts.count - 1].redirect_url.to_s


    end

    v_action_text = %{
        end_traction("#{step_name}", trans_time)
    }

    file_text = File.read(perf_file_name)
    file_text_mod = file_text.gsub('#v_action end', '          ' + v_action_text.strip + "\n\n" + '#v_action temp end')
    file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
    open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

  end

  page.driver.clear_network_traffic

end
