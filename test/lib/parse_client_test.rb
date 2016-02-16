require 'test_helper'
require './lib/assets/parse_client'


describe ParseClient do
  before do
  end

  it "ParseClient#login - session token must be String" do
    clinet = ParseClient.new('b0yiVianh3FBoPwXycBEWNBDbhkvsVT4eRDzP6it', 'Cl5kJTAIl8gG18oAAiaQdeuNQtVDQIRplhede1XF')

    # login
    json = clinet.login('kenzan8000', 'Haseken8')
    session_token = json['sessionToken']

    puts "session_token: #{session_token}"
    session_token.must_be_kind_of String
  end
end


describe ParseClient do
  before do
  end

  it "ParseClient#get_class - results must be Array" do
    clinet = ParseClient.new('b0yiVianh3FBoPwXycBEWNBDbhkvsVT4eRDzP6it', 'Cl5kJTAIl8gG18oAAiaQdeuNQtVDQIRplhede1XF')

    # login
    json = clinet.login('kenzan8000', 'Haseken8')
    session_token = json['sessionToken']

    # request to parse
    params = { 'limit' => '1000', 'order' => '-time' }
    date_index = DateTime.new(2000, 1, 1)
    params['where'] = "{\"time\":{\"$lte\": #{date_index.to_time.to_f}}}"
    json = clinet.get_class('testData', session_token, params)
    json['results'].must_be_kind_of Array
  end

end
