def recursive_list_variable(variable, prev = '')
  data = {}

  if (variable.kind_of?(Array)) then

    variable.each_with_index do |value, key|

      variable_key = prev + '[' + key.to_s + ']'

      if (variable[key].kind_of?(Array)) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      elsif (variable[key].kind_of?(Hash)) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      else
        data[variable_key] = value
      end
    end

  elsif (variable.kind_of?(Hash)) then

    variable.each do |key, value|

      variable_key = prev + '["' + key.to_s + '"]'

      if (variable[key].kind_of?(Array)) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      elsif (variable[key].kind_of?(Hash)) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      else
        data[variable_key] = value
      end

    end
  elsif (variable.nil?)
    data['nil'] = ''
  end

  return data
end



def generate_performance_test_script(scenario)

  step_name = scenario.steps.to_a[$step].name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize
  scenario_name  = scenario.name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize
  $step = $step + 1
  if (page.driver.network_traffic.to_a.count > 0) then

  perf_file_name = 'features/step_definitions/performance/' + scenario_name.downcase + '.rb'

  #if (!File.file?(perf_file_name))
  if ($file_not_created == true) then

    $file_not_created = false

    file_structure = %{

#  #{scenario.name}

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


  if ($function_call_name.count > 0) then

    for i in $function_call_start..$function_call_name.count - 1

      function_argouments = ''
      puts $function_call_arguments[i]

      if (!$function_call_arguments[i].nil?)
        $function_call_arguments[i].each do |key, value|
          puts $function_call_arguments[i]
         if (function_argouments != '') then
           function_argouments = function_argouments + ', '
         end
          if (value.class.to_s == 'String') then

            func_value = value.to_s

            if (i > 0) then
              for i2 in 0..i - 1
                value_list = recursive_list_variable($function_call_data[i2])
                  value_list.each do |data_key, data_value|
                    if (data_value.to_s.length > 0) then
                    func_value = func_value.gsub(/#{data_value.to_s}/i, '#{' + "genData#{i2}" + data_key + '}')
                  end
                end
              end
            end

            function_argouments = function_argouments + '"' + func_value + '"'


          else

            func_value = value.to_s

            if (i > 0) then
              for i2 in 0..i - 1
                value_list = recursive_list_variable($function_call_data[i2])
                value_list.each do |data_key, data_value|

                  if (data_value.to_s.length > 0) then
                    puts data_value.to_s + ' - ' + '"#{' + "genData#{i2}" + data_key + '}"' + ' - ' + "genData#{i2}" + data_key
                    func_value = func_value.gsub(/"#{data_value.to_s}"/is, '"#{' + "genData#{i2}" + data_key + '}"')

                    func_value = func_value.gsub(/ "#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}"/is, ' "#{' + "genData#{i2}" + data_key + '}"')
                    func_value = func_value.gsub(/"#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}",/is, '"#{' + "genData#{i2}" + data_key + '}",')
                    func_value = func_value.gsub(/\=\>"#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}\}"/is, '=>"#{' + "genData#{i2}" + data_key + '}"}')
                    func_value = func_value.gsub(/\["#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}"\]/is, '["#{' + "genData#{i2}" + data_key + '}"]')


                    func_value = func_value.gsub(/ #{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}/is, " genData#{i2}" + data_key)
                    func_value = func_value.gsub(/#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')},/is, "genData#{i2}" + data_key + ',')
                    func_value = func_value.gsub(/\=\>#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}\}/is, '=>' + "genData#{i2}" + data_key + '}')
                    func_value = func_value.gsub(/\[#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}\]/is, '[' + "genData#{i2}" + data_key + ']')

                  end
                end
              end
            end


            function_argouments = function_argouments + func_value
          end
        end

      end


      v_action_text = %{

          genData#{i} = #{$function_call_name[i]}(#{function_argouments})
      }

      file_text = File.read(perf_file_name)
      file_text_mod = file_text.gsub('#v_action end', '         ' + v_action_text.strip + "\n\n" + '#v_action temp end')
      file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
      open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

    end

    $function_call_start = $function_call_name.count

  end

  v_action_text = %{

      trans_time = start_traction("#{step_name}")
  }

  file_text = File.read(perf_file_name)
  file_text_mod = file_text.gsub('#v_action end', '         ' + v_action_text.strip + "\n\n" + '#v_action temp end')
  file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
  open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


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


          request_url = request.url

          for i in 0..$function_call_data.count - 1

            value_list = recursive_list_variable($function_call_data[i])

              value_list.each do |data_key, data_value|

              if (data_value.to_s.length > 2) then

                if (request_url.include? "#{CGI::escape(data_value.to_s)}")

                  puts CGI::unescape(data_value.to_s)
                  request_url = request_url.gsub(/#{CGI::escape(data_value.to_s)}/i, '#{' + "genData#{i}" + data_key + '}')

                end
              end

            end

          end


          if (request.method == 'POST')
            data_str = Base64.decode64(request.data)


            v_action_text = %{
                  data["post_data"] = {}
            }

            file_text = File.read(perf_file_name)
            file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n" + '#v_action temp end')
            file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
            open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }


            data_str_and = data_str.split('&')

            data_str_and.each do |elements|
              data_str_keyvalue = elements.split('=')
              post_key = CGI::unescape(data_str_keyvalue[0])

              if (data_str_keyvalue[1].nil?) then
                data_str_keyvalue[1] = ''
              end

              post_value = '"' + CGI::unescape(data_str_keyvalue[1]).gsub('"', '\"') + '"'

              for i in 0..$function_call_data.count - 1

                  value_list = recursive_list_variable($function_call_data[i])

                  value_list.each do |data_key, data_value|
                    if (CGI::unescape(data_str_keyvalue[1]).to_s == data_value.to_s) then
                      post_value = "genData#{i}#{data_key.to_s}"
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

            v_action_text = %{
                  response = http_post(@curl, data, "#{request_url}")
            }

          else

            v_action_text = %{
                  response = http_get(@curl, data, "#{request_url}")
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


def decode_value(variable_item)
  if variable_item.nil? then
    item = nil
  elsif (variable_item.class.to_s == 'Array') then
    item = variable_item
  elsif (variable_item.class.to_s == 'String') then
    item = variable_item
  elsif (variable_item.class.to_s == 'Cucumber::Ast::DocString') then
    if variable_item.to_s.empty? then
      item = nil
    else
      item = variable_item
    end
  elsif (variable_item.class.to_s == 'Cucumber::Ast::Table') then
    if variable_item.to_s.empty? then
      item = nil
    else
      item = variable_item.raw
    end


  else
    item = variable_item
  end

  return item

end
