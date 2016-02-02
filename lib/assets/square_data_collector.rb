require './lib/assets/mgpqm_converter'
require './lib/assets/parse_client'
require 'date'


# square data collector
module SquareDataCollector

  # get data from parse
  def self.get_data_from_parse(end_date, start_date)
    clinet = ParseClient.new('b0yiVianh3FBoPwXycBEWNBDbhkvsVT4eRDzP6it', 'Cl5kJTAIl8gG18oAAiaQdeuNQtVDQIRplhede1XF')

    # login
    json = clinet.login('kenzan8000', 'Haseken8')
    session_token = json['sessionToken']

    # get data
    data = []
    are_results = true
    date_index = end_date
    while are_results do
      # request to parse
      params = { 'limit' => '1000', 'order' => '-time' }
      params['where'] = "{\"time\":{\"$lte\": #{date_index.to_time.to_f}}}"
      json = clinet.get_class('testData', session_token, params)
      are_results = (json['results'] && json['results'].length > 0)

      # convert results to human readable unit of measurement
      if are_results
        results = SquareDataCollector.import_json(json)
        data += results
        last_time = results.last['time'].to_f
        date_index = DateTime.strptime("#{last_time}",'%s')
        break if last_time <= start_date.to_time.to_f
      end
    end
    data
  end

  # import json
  def self.import_json(json)
    sensitivity_code_so2 = 30.0
    sensitivity_code_ozone_s = 17.55
    converter = MGQMConverter.new(sensitivity_code_so2, sensitivity_code_ozone_s)

    results = json['results']
    results.each do |result|
      result['CO'] = converter.convert_co(result['CO'], result['Temp_C'])
      result['Ozone_S'] = converter.convert_ozone_s(result['Ozone_S'], result['Temp_C'])
      result['SO2'] = converter.convert_so2(result['SO2'], result['Temp_C'])
      result['UV'] = converter.convert_uv(result['UV'])
    end
    results
  end

end


#require 'json'
#file = File.read('vasp.json')
#json = JSON.parse(file)
#json_hash = SquareDataCollector.import_json(json)
#
#now = DateTime.now
#json_hash = SquareDataCollector.get_data_from_parse(now, now-30)
#File.open('_vasp.json', 'w') do |f|
#  f.write(json_hash.to_json)
#end
#
#puts now.to_time.to_f
