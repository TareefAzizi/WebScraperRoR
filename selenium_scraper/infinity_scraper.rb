require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.headless!

driver = Selenium::WebDriver.for(:chrome, capabilities: [options])
driver.get "https://www.rottentomatoes.com/browse/movies_in_theaters/"

movies_name_selector = "div.discovery-tiles div[slot=caption] span.p--small"

loop do
  movies_count = driver.find_elements(css: movies_name_selector).size

  begin
    puts "> #{movies_count} movies loaded so far..."
    button = driver.find_element(css: "div.discovery__actions button")
    button.click

    puts "--- Load More button is clicked"
    sleep(3)

  rescue Exception => e
    puts "Loading is done!!!"
    break
  end
end

count = 0
driver.find_elements(css: movies_name_selector).each do |e|
  name = e.text

  puts '------------------'
  puts "#{count += 1} - #{name}"
end

driver.quit