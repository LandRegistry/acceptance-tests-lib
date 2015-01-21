def check_logs_for_message(url, log_message)

  if $ENVIRONMENT == "preview" then

    uri = URI.parse(url + "?start="+($log_start_time - 40000).to_s)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    found = false
    count = 0
    while (found == false && count < 30) do
      puts 'Checking Audit'
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      if (response.body.include? log_message) then
        found = true
      end

      count = count + 1
      sleep(1) #
    end

    assert_match(log_message, response.body, 'Expected to find audit message in logs')

  end

end
