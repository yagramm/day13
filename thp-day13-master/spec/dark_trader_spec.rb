require_relative '../lib/dark_trader'

describe "the crypto_name_array method" do
  it "should return an array of hashes with cryptocurrencies codes and prices, first key of first hash being 'BTC'" do
    expect((crypto_name_array)[0].keys[0]).to eq("BTC")
  end
end
