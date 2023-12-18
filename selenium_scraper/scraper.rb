require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.headless!

driver = Selenium::WebDriver.for(:chrome, capabilities: [options])
driver.get "https://github.com/search?q=Ruby+Web+Scraping"

driver.find_elements(css: ".repo-list li").each do |e|
  name = e.find_element(css: 'a.v-align-middle').text
  description = e.find_element(css: 'p.mb-1').text.strip

  puts '------------------'
  puts "#{name}"
  puts "#{description}"
end

driver.quit