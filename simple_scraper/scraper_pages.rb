require "open-uri"
require "nokogiri"

def scrapping
  url = "https://github.com/search?q=Ruby+Web+Scraping"
  items_array = []

  html = URI.open(url)
  doc = Nokogiri::HTML(html)

  # getting the total results
  total_result = doc.css("div .d-flex.flex-column.flex-md-row.flex-justify-between.border-bottom.pb-3.position-relative h3").text.split(" ")[0].to_i

  results_per_page = 10
  max_page = (total_result / results_per_page).floor + 1

  for page in 1..max_page
    puts "Scrapping page #{page}..."

    html = URI.open(url + "&p=#{page}")
    doc = Nokogiri::HTML(html)

    doc.search(".repo-list li").each do |element|
      name = element.css("a.v-align-middle").text
      description = element.css("p.mb-1").text.strip

      # Array of objects
      item = {
        name: name,
        description: description
      }

      # items_array << item
      items_array.push(item)
    end

    # To prevent exceeding rate limit that caused the 429 Too Many Request Error.
    sleep(10)
  end

  items_array.each_with_index do |item, index|
    puts "--------------------"
    puts "#{index + 1} - #{item[:name]}"
    puts "#{item[:description]}"
  end
end

def scrapping_method_2
  url = "https://github.com/search?q=Ruby+Web+Scraping"
  items_array = []
  page = 1
  next_page = true

  while next_page
    puts "Scrapping page #{page}..."

    html = URI.open(url + "&p=#{page}")
    doc = Nokogiri::HTML(html)

    doc.search(".repo-list li").each do |element|
      name = element.css("a.v-align-middle").text
      description = element.css("p.mb-1").text.strip

      # Array of objects
      item = {
        name: name,
        description: description
      }

      # items_array << item
      items_array.push(item)
    end

    # Check if there is a disabled next button somewhere on the page
    disabled_next_button = doc.search("span.next_page.disabled")
    if disabled_next_button.any?
      next_page = false # stope the loop from running again
    else
      page += 1
    end

    sleep(10)
  end

  # Showing all results in the console
  items_array.each_with_index do |item, index|
    puts "--------------------"
    puts "#{index + 1} - #{item[:name]}"
    puts "#{item[:description]}"
  end
end

# scrapping
scrapping_method_2
