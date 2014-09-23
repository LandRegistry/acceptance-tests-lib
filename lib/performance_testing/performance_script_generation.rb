#####
## Function: recursive_list_variable
## Inputs: variable (any Hash/Array/nil) prev (string of current path)
## Outputs: Flat hash (key = path, value = value)
## Description: This function creates a flat hash of the object so it can be
##              easily used to paramterise the performance script.
##              This is a recursive function.
#####
def recursive_list_variable(variable, prev = '')

  # create the hash
  data = {}

  ## If the variable is an array we need to use .each_with_index.
  if (variable.kind_of?(Array)) then

    # Loop through the items of the array
    variable.each_with_index do |value, key|
      # build the variable path, this is the structure of the object
      variable_key = prev + '[' + key.to_s + ']'

      # If the child is either an Array or Hash then it needs to be put
      # back into this function.
      if ((variable[key].kind_of?(Array)) || (variable[key].kind_of?(Hash))) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      else
        # Otherwise we're at the top for this part, so assign the value to the data hash
        data[variable_key] = value
      end
    end

  # The same code as above, but instead needs to use .each
  elsif (variable.kind_of?(Hash)) then

    # Loop through the items of the array
    variable.each do |key, value|

      # build the variable path, this is the structure of the object
      variable_key = prev + '["' + key.to_s + '"]'

      # If the child is either an Array or Hash then it needs to be put
      # back into this function.
      if ((variable[key].kind_of?(Array)) || (variable[key].kind_of?(Hash))) then
        data_ret = recursive_list_variable(variable[key], variable_key)
        data = data_ret.merge(data)
      else
      # Otherwise we're at the top for this part, so assign the value to the data hash
        data[variable_key] = value
      end

    end
    # If it is nil, then we need to return a hash still, this will be reworked in the future
  elsif (variable.nil?)
    data['nil'] = ''
  end

  # Return data hash
  return data
end


#####
## Function: generate_performance_test_script
## Inputs: scenario object (this contains data about the scenario. i.e. name)
## Outputs: None
## Description: This will generate the load test for a step.
## =>           This will use phantomjs to work out which http requests were made
## =>           It will work out the variables being used and paramatise them in the script
## =>           It will create the file if it doesn't exist
#####
def generate_performance_test_script(scenario)

  ## the scenario object doesn't know what the current step it, this will
  ## work it out and structure it how we want to use it
  step_name = scenario.steps.to_a[$step].name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

  ## Use a global variable to keep track of the step. As this fucntion is just
  ## called once per a step, so we can increase this by 1
  $step = $step + 1

  # get the scenario name, ( and ) can confuse regex and spaces we want as underscores
  scenario_name  = scenario.name.gsub('(','').gsub(')', '').gsub(/ /, '_').capitalize

  # We only want to do something if there was any http traffic
  if (page.driver.network_traffic.to_a.count > 0) then

    perf_file_name = 'performanceTests/' + scenario_name.downcase + '.rb'


    # We want to recreate the script each time it runs. This variable keeps track of it
    #if (!File.file?(perf_file_name))
    if ($file_not_created == true) then
      # Set this to another value so we don't keep recreating the performance script
      $file_not_created = false

      # Lets create the basic structure of the file
      file_structure = %{

  # Scenario Name: #{scenario.name}

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

      # Lets write that to a file
      File.open(perf_file_name, 'w') { |file| file.write(file_structure) }

    end

    # This bit gets complex. We record which functions were being called.
    # If this is above 0 then we want to understand this fucntions as this is
    # key to being able to paramertise the script
    if ($function_call_name.count > 0) then

      # Loop through the function calls as we only want to use the new ones
      for i in $function_call_start..$function_call_name.count - 1

        function_argouments = ''
        #puts $function_call_arguments[i]

        if (!$function_call_arguments[i].nil?)
          $function_call_arguments[i].each do |key, value|
            #puts $function_call_arguments[i]
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
                      func_value = func_value.gsub(/"#{data_value.to_s}"/is, '"#{' + "genData#{i2}" + data_key + '}"')

                      #func_value = func_value.gsub(/ "#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}"/is, ' "#{' + "genData#{i2}" + data_key + '}"')
                      #func_value = func_value.gsub(/"#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}",/is, '"#{' + "genData#{i2}" + data_key + '}",')
                      #func_value = func_value.gsub(/\=\>"#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}\}"/is, '=>"#{' + "genData#{i2}" + data_key + '}"}')
                      #func_value = func_value.gsub(/\["#{data_value.to_s.gsub('(', '\(').gsub(')', '\)')}"\]/is, '["#{' + "genData#{i2}" + data_key + '}"]')
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

        write_line_to_performance_test_file(perf_file_name, v_action_text)

      end

      $function_call_start = $function_call_name.count

    end

    v_action_text = %{

        trans_time = start_traction("#{step_name}")
    }

    write_line_to_performance_test_file(perf_file_name, v_action_text)

      prevredirect = '';
      page.driver.network_traffic.each do |request|

        if (!request.url.include? 'data:application') then

          if (prevredirect == '') then

            #puts request.response_parts[0].redirect_url


              v_action_text = %{
                    data = {}
                    data["header"] = {}
              }

            write_line_to_performance_test_file(perf_file_name, v_action_text)


            if (request.headers.count > 0) then

              request.headers.each do |value|
                  if (value['name'] != 'Content-Length') then

                    v_action_text = %{
                          data["header"]["#{value['name']}"] = "#{value['value']}"
                    }

                    write_line_to_performance_test_file(perf_file_name, v_action_text)

                end

              end

            end


            request_url = request.url

            for i in 0..$function_call_data.count - 1

              value_list = recursive_list_variable($function_call_data[i])

                value_list.each do |data_key, data_value|

                if (data_value.to_s.length > 2) then

                  if (request_url.include? "#{CGI::escape(data_value.to_s)}")

                    #puts CGI::unescape(data_value.to_s)
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

              write_line_to_performance_test_file(perf_file_name, v_action_text)

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


                write_line_to_performance_test_file(perf_file_name, v_action_text)

              end

              v_action_text = %{
                    response = http_post(@curl, data, "#{request_url}")
              }

            else

              v_action_text = %{
                    response = http_get(@curl, data, "#{request_url}")
              }

            end

            write_line_to_performance_test_file(perf_file_name, v_action_text)

          end


          if (request.response_parts[request.response_parts.count - 1].redirect_url.to_s == '') then

            v_action_text = %{
            assert_http_status(response, #{request.response_parts[request.response_parts.count -1].status})
            }

            write_line_to_performance_test_file(perf_file_name, v_action_text)

          end

      end

      prevredirect = request.response_parts[request.response_parts.count - 1].redirect_url.to_s


    end

    v_action_text = %{
        end_traction("#{step_name}", trans_time)
    }

    write_line_to_performance_test_file(perf_file_name, v_action_text)

  end

  # Clear out the network traffic log so we don't end up with duplicates
  page.driver.clear_network_traffic

end


#####
## Function: decode_value
## Inputs: object (any object type)
## Outputs: object (transformed object)
## Description: This function should be called within other functions to transform
##              the object into something that can be converted to a string.
## =>           an example is Cucumber::Ast::Table is a text table, but it needs to be
## =>           the raw version.
#####
def decode_value(variable_item)
  # If the item is a nil, then change it to a nil
  if variable_item.nil? then
    item = nil
  # Arrays are ok to pass through as they are
  elsif (variable_item.class.to_s == 'Array') then
    item = variable_item
  elsif (variable_item.class.to_s == 'String') then
    item = variable_item
  # A Cucumber Docstring needs to be checked if it is empty or not
  elsif (variable_item.class.to_s == 'Cucumber::Ast::DocString') then
    if variable_item.to_s.empty? then
      item = nil
    else
      item = variable_item
    end
  # A Cucumber Table needs to be the raw format
  elsif (variable_item.class.to_s == 'Cucumber::Ast::Table') then
    if variable_item.to_s.empty? then
      item = nil
    else
      item = variable_item.raw
    end
  else
    # else keep it as it is
    item = variable_item
  end

  return item

end


#####
## Function: write_line_to_performance_test_file
## Inputs: perf_file_name (String) v_action_text (String)
## Outputs: None
## Description: This will write the action text to the performance test script
#####
def write_line_to_performance_test_file(perf_file_name, v_action_text)

  # Open the file to read
  file_text = File.read(perf_file_name)
  # get the text of the file and add the new code to the end of #v_action end
  file_text_mod = file_text.gsub('#v_action end', '             ' + v_action_text.strip + "\n\n" + '#v_action temp end')
  # Add the v#_action_end text back it. Doing this with the temp stops a recursive command
  file_text_mod = file_text_mod.gsub('#v_action temp end', '#v_action end')
  # Write it back to the file
  open(perf_file_name, 'w') { |file| file.puts(file_text_mod) }

end
