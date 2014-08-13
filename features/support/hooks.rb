

Before do | scenario |
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize($http_auth_name, $http_auth_password)
  end
  $log_start_time = (Time.now.to_f * 1000).to_i
end

After do | scenario |
  if (!scenario.passed?)
      save_screenshot("sshot-#{Time.new.to_i}.png", :full => true)
  end
end
