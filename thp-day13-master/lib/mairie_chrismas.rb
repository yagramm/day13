##https://www.thehackingproject.org/dashboard/courses/1/weeks/2/days/4?locale=fr
#scrapes a list of all townhalls from Val d'Oise into an array of hashes with names of town and e-mails of each townhall

require 'nokogiri'
require 'pry'
require 'open-uri'

def get_townhall_email(url) #Scrape name and email from a single townhall page and store it into a hash
  page = Nokogiri::HTML(open(url))
  name_email_hash = Hash.new
  townhall_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()').to_s
  townhall_name = page.xpath('/html/body/div/main/section[1]/div/div/div/h1/text()').to_s[0...-8]
  name_email_hash = {townhall_name => townhall_email}
  return name_email_hash
end

def get_townhall_urls (url) #Scrape urls of each townhall from one page and store it into an array
  page = Nokogiri::HTML(open(url))
  townhall_urls_array = Array.new
  townhall_page = page.xpath('//a[@class="lientxt"]/@href').to_a
  for i in (0..townhall_page.length) do
    townhall_urls_array << ("http://annuaire-des-mairies.com#{townhall_page[i].to_s[1..-1]}")
  end
  return townhall_urls_array
end

def scrapper #Loop on an array of townhall urls, scrape each townhall page, store each name/email in a hash, store each hash into an array
  final_array = Array.new
  #create an array of the urls of each townhall page
  urls_array = get_townhall_urls("http://annuaire-des-mairies.com/val-d-oise.html")
  #loop on the array of urls
  for i in (0..urls_array.length-2) do
    #create a single hash with name and email of each townhall and store it into an array
    final_array << get_townhall_email(urls_array[i])
    #print each single hash with name and email (to follow what programm is doing)
    puts get_townhall_email(urls_array[i])
  end
  return final_array
end

def perform
  scrapper_out = scrapper
  puts "Array of #{scrapper_out.length} townhalls emails done !!"
  puts "Press enter to display it."
  gets
  print scrapper_out
  puts ""
end

perform
