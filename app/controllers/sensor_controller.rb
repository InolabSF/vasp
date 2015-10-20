require './lib/assets/math_utility'


class SensorController < ApplicationController

  skip_before_filter :verify_authenticity_token

=begin
  @apiVersion 0.1.0

  @apiGroup Sensor
  @api {get} /sensor
  @apiName Sensor
  @apiDescription get environmental sensor data

  @apiParam {Number} lat                        Mandatory latitude
  @apiParam {Number} lng                        Mandatory longitude
  @apiParam {Number} radius                     Mandatory radius that represents radius of square
  @apiParam {Number} type                       Mandatory sensor type
  @apiParam {example} type.humidity      1

  @apiParamExample {json} Request-Example:
    {
      "lat": 37.76681832250885,
      "lng": -122.4207906162038,
      "radius": 3.0,
      "type": 1, // humidity
    }

  @apiSuccess {Number} type sensor type
  @apiSuccess {Number} lat Latitude
  @apiSuccess {Number} lng Longitude
  @apiSuccess {Number} weight sensor value
  @apiSuccess {String} timestamp Timestamp
  @apiSuccess {Number} application_code if the request succeeded or failed

  @apiSuccessExample {json} Success-Response:
    {
      "sensors": [
        {
          "created_at": "2015-05-07T01:25:39.744Z",
          "id": 1,
          "lat": 37.792097317369965,
          "lng": -122.43528085596421,
          "type": 1,
          "timestamp": "2015-05-07T01:25:39.738Z",
          "updated_at": "2015-05-07T01:25:39.744Z",
          "weight": 57.23776223776224
        }
      ],
      "application_code": 200
    }
=end
  def get
    # get latitude, longitude
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    radius = params[:radius].to_f
    type = params[:type].to_i

    # calculate distance of latitude and longitude degree
    lat_degree = MathUtility.get_lat_degree(lat, lng, radius)
    lng_degree = MathUtility.get_lng_degree(lat, lng, radius)
    do_return_json = !(lat_degree == 0 || lng_degree == 0)
    application_code = do_return_json ? 200 : 400

    # response
    if do_return_json
      sensors = Sensor.where(
        type: type,
        lat: (lat-lat_degree)..(lat+lat_degree),
        lng: (lng-lng_degree)..(lng+lng_degree)
      )
      json = Jbuilder.encode do |j|
        j.application_code(application_code)
        j.sensors(sensors)
      end
      render json: json
    else
      render json: { :application_code => application_code }
    end
  end

=begin
  @apiVersion 0.1.0

  @apiGroup Sensor
  @api {post} /sensor
  @apiName Sensor
  @apiDescription post new environmental sensor data

  @apiParam {Number} lat                        Mandatory latitude
  @apiParam {Number} lng                        Mandatory longitude
  @apiParam {Number} weight                     Mandatory sensor value
  @apiParam {Number} type                       Mandatory sensor type
  @apiParam {example} type.humidity      1

  @apiParamExample {json} Request-Example:
    {
      "sensors": [
        {
          "lat": 37.792097317369965,
          "lng": -122.43528085596421,
          "weight": 57.23776223776224,
          "timestamp": "2015-05-07T01:25:39.738Z"
        }
      ]
      "type": 1
    }

  @apiSuccess {Number} application_code if the request succeeded or failed

  @apiSuccessExample {json} Success-Response:
    {
      "application_code": "200"
    }
=end
  def post
    # check json
    do_return_json = true
    type = params[:type].to_i
    do_return_json = false if !(type.is_a? Integer) || !(SensorType.find_by_id type)
    sensors_json  = params[:sensors]
    do_return_json = false unless sensors_json
    unless do_return_json
      render json: { :application_code => 400 }
      return
    end

    # create sensors
    sensors_json.each do |sensor_json|
      sensor = Sensor.new
      #next unless sensor_json[:timestamp]
      #sensor.timestamp = DateTime.strptime(sensor_json[:timestamp], '%Y-%m-%dT%H:%M:%S.%LZ')
      sensor.timestamp = DateTime.now
      sensor.lat = sensor_json[:lat]
      sensor.lng = sensor_json[:lng]
      sensor.weight = sensor_json[:weight]
      sensor.type = type
      sensor.save if sensor.valid?
    end
    render json: { :application_code => 200 }
  end

=begin
  @apiVersion 0.1.0

  @apiGroup Sensor
  @api {get} /sensor/type
  @apiName SensorType
  @apiDescription get types of sensor

  @apiSuccess {Number} id id of sensor type
  @apiSuccess {String} name name of sensor type

  @apiSuccessExample {json} Success-Response:
    {
      "types": [
        {
          "id": 1,
          "name": "humidity"
        }
      ],
      "application_code": 200
    }
=end
  def type
    types = SensorType.all
    json = []
    types.each do |type|
      json.push(type.as_json['attributes'])
    end

    render json: { :types => json, :application_code => 200 }
  end

end
