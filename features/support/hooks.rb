

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
end

After do | scenario |

  if (scenario.failed?)
      save_screenshot("sshot-#{Time.new.to_i}.png", :full => true)
  end

end


AfterStep do | scenario |

  puts scenario.name

  page.driver.network_traffic.each do |request|
    begin
      puts request.url
      puts '--- ' + request.method
      puts '--- ' + request.data
    rescue

    end
  end

  page.driver.clear_network_traffic


end
