require 'faraday'
require 'json'


class ParseClient

  # initialize
  def initialize(applicatino_id, api_key)
    @applicatino_id = applicatino_id
    @api_key = api_key
  end

  # login
  def login(username, password)
    connection = Faraday.new(:url => 'https://api.parse.com/1/login') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.get do |request|
      request.params['username'] = username
      request.params['password'] = password
      request.headers['X-Parse-Application-Id'] = @applicatino_id
      request.headers['X-Parse-REST-API-Key'] = @api_key
      request.headers['X-Parse-Revocable-Session'] = '1'
    end
    JSON.parse(response.body)
  end

  # get class
  def get_class(class_name, session_token, params={})
    connection = Faraday.new(:url => "https://api.parse.com/1/classes/#{class_name}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.get do |request|
      params.each do |key, value|
        request.params[key] = value
      end

      request.headers['X-Parse-Application-Id'] = @applicatino_id
      request.headers['X-Parse-REST-API-Key'] = @api_key
      request.headers['X-Parse-Session-Token'] = session_token
    end
    JSON.parse(response.body)
  end

  # post class
  def post_class(class_name, json)
    connection = Faraday.new(:url => "https://api.parse.com/1/classes/#{class_name}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.post do |request|
      request.headers['X-Parse-Application-Id'] = @applicatino_id
      request.headers['X-Parse-REST-API-Key'] = @api_key
      request.body = "#{json}"
    end
    JSON.parse(response.body)
  end

  # put class
  def put_class(class_name, object_id, json)
    connection = Faraday.new(:url => "https://api.parse.com/1/classes/#{class_name}/#{object_id}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.put do |request|
      request.headers['X-Parse-Application-Id'] = @applicatino_id
      request.headers['X-Parse-REST-API-Key'] = @api_key
      request.headers['Content-Type'] = 'application/json'
      request.body = "#{json}"
    end
    JSON.parse(response.body)
  end

  # delete class
  def delete_class(class_name, object_id)
    connection = Faraday.new(:url => "https://api.parse.com/1/classes/#{class_name}/#{object_id}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = connection.delete do |request|
      request.headers['X-Parse-Application-Id'] = @applicatino_id
      request.headers['X-Parse-REST-API-Key'] = @api_key
    end
    JSON.parse(response.body)
  end

end


#clinet = ParseClient.new('CShZ06wMC9q0ZzNQjSgnJpdlI7kXg2nsiWcaWBJo', 'vAGF8nhA5ZbfEQpjz7DmzKpJZhfofOUEs03Nxey9')
#puts clinet.login('kenzan8000', 'Haseken8')
