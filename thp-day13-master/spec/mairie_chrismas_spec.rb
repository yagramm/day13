require_relative '../lib/mairie_chrismas'

describe "the get_townhall_email(url) method" do
  it "should return name and email of townhall page http://annuaire-des-mairies.com/95/ermont.html" do
    expect(get_townhall_email("http://annuaire-des-mairies.com/95/ermont.html")).to eq({"ERMONT" => "mairie@ville-ermont.fr"})
  end
end
describe "the get_townhall_urls[1] method" do
  it "should return url of the first town on page http://annuaire-des-mairies.com/val-d-oise.html" do
    expect(get_townhall_urls("http://annuaire-des-mairies.com/val-d-oise.html")[0]).to eq("http://annuaire-des-mairies.com/95/ableiges.html")
  end
end
