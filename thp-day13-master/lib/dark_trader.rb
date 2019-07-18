#https://www.thehackingproject.org/dashboard/courses/1/weeks/2/days/4?locale=fr
#scrapes a list of all cryptocurrencies into an array of hashes with codes and prices of each cryptocurrencie

require 'nokogiri'
require 'pry'
require 'open-uri'


def crypto_name_array
  puts "Loading cryptocurrencies page. Please wait..."
  url_target = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(open(url_target))
  crypto_name_array = Array.new
  crypto_couple_hash = Hash.new

  crypto_names = page.xpath('//a[@class="link-secondary"]/text()')
  crypto_price = page.xpath('//a[@class="price"]/text()')

  for i in (0..crypto_names.length-1) do
    crypto_couple_hash = {(crypto_names[i].to_s) => ((crypto_price[i].to_s)[1..-1].to_f)}
    puts "Now scraping crypto currencie #{crypto_couple_hash}."
    crypto_name_array << crypto_couple_hash
  end
  return crypto_name_array
end

def perform
  array_out = crypto_name_array
  puts "Array of #{array_out.length} cryptocurrencies done !!"
  puts "Press enter to display it."
  gets
  print array_out
  puts ""
end

perform
