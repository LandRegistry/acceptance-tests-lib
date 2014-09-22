

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
  $function_call_arguments = []
  $function_call_start = 0

  $file_not_created = true
end

After do | scenario |
  if (scenario.failed?)
      save_screenshot("sshot-#{Time.new.to_i}.png", :full => true)
  end

end


AfterStep do | scenario |
  if (!ENV['GENERATE_PERFORMANCE_SCRIPT'].nil?) then
    generate_performance_test_script(scenario)
  end

end
