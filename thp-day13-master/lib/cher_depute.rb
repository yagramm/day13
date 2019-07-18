#https://www.thehackingproject.org/dashboard/courses/1/weeks/2/days/4?locale=fr

require 'nokogiri'
require 'pry'
require 'open-uri'

def get_depute_email_hash (url)
  depute_email_hash = Hash.new
  page = Nokogiri::HTML(open(url))
  depute_email = page.xpath('//dd[4]/ul/li[2]/a/text()').to_s
  depute_full_name = page.xpath('//*[@id="haut-contenu-page"]/article/div[1]/ol/li[5]/text()').to_s
  depute_full_name_array = depute_full_name.split(" ")
  depute_first_name = depute_full_name_array[1]
  depute_last_name = depute_full_name_array[2]
  depute_email_hash = {"first_name" => depute_first_name, "last_name" => depute_last_name, "email" => depute_email}
  return depute_email_hash
end

def get_depute_urls_array (url)
  page = Nokogiri::HTML(open(url))
  depute_urls_array = Array.new
  depute_page = page.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href').to_a
  puts "Scraping urls of depute pages. Please wait..."
  for i in (0..depute_page.length) do
    build_url = ("http://www2.assemblee-nationale.fr#{depute_page[i].to_s[0..-1]}")
    depute_urls_array << build_url
  end
  return depute_urls_array
end

def scrapper #Loop on an array of depute page urls, scrape each depute page url, store each depute details in a hash, store each hash into an array
  final_array = Array.new
  #create an array of the urls of each depute page
  urls_array = get_depute_urls_array("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
  #loop on the array of urls
  for i in (0..urls_array.length-1) do
    #create a single hash with first name, last name and email of each depute and store it into an array
    depute_email_hash = get_depute_email_hash(urls_array[i])
    puts depute_email_hash
    final_array << depute_email_hash
    #final_array << get_depute_email_hash(urls_array[i])
    #print each single hash details (to follow what programm is doing)
    #puts get_depute_email_hash(urls_array[i])
  end
  return final_array
end

def perform
  #Please corrector ignore this. It's here in case access to website is blocked
  #puts "This is a short test of get_depute_urls_array"
  #puts "Print the hash of a depute page"
  #get_depute_urls_array ("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

  #print get_depute_email_hash("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")
  #depute_urls_array = get_depute_urls_array ("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
  #print depute_urls_array

  scrapper_out = scrapper
  puts "Array of #{scrapper_out.length} depute details with emails done !!"
  puts "Press enter to display it."
  gets
  print scrapper_out
  puts ""
end



perform
