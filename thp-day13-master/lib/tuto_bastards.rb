# http://ruby.bastardsbook.com/chapters/html-parsing/

require 'nokogiri'
require 'pry'
require 'open-uri'

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"

page = Nokogiri::HTML(open(PAGE_URL))

puts "- Examples of page.css('tag') usage"
puts page.class   # => Nokogiri::HTML::Document
puts page.css("title")[0].name   # => title
puts page.css("title")[0].text   # => My webpage

puts "- Scrap links"
links = page.css("a")
puts links.length   # => 6
puts links[0].text   # => Click here
puts links[0]["href"] # => http://www.google.com

puts "- select section in page"
page = Nokogiri::HTML(open(PAGE_URL))
news_links = page.css("a").select{|link| link['data-category'] == "news"}
news_links.each{|link| puts link['href'] }

#=>   http://reddit.com
#=>   http://www.nytimes.com

puts news_links.class   #=>   Array
