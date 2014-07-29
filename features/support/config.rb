### Includes Capybara (the visit, find, fill_in commands) and poltergeist (channel to phantomjs headless browser)
require 'capybara/cucumber'
require 'capybara/poltergeist'

### Allows you to use the page. commands
include Capybara::DSL

### Configures Capybara to use Xpath selectors and use poltergeist driver
Capybara.default_selector = :xpath
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 10
Capybara.app_host = 'http://localhost:4567' # change url

### Set the options for poltergeist to use
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true)
end

### Reads the basic auth username and password from env settings
$http_auth_name = (ENV['HTTPAUTH_USERNAME'] || '')
$http_auth_password = (ENV['HTTPAUTH_PASSWORD'] || '')

### Includes the unit testing framework
require 'test/unit'
### Allows the functions (assert_equals to work)
include Test::Unit::Assertions
