class SensorController < ApplicationController

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

  @apiSuccessExample {json} Success-Response:
    {
      "sensor_datas": [
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
      ]
    }
=end
  def index
    # get latitude, longitude
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    radius = params[:radius].to_f
    sensor_type = params[:sensor_type].to_i

    # calculate distance of latitude and longitude degree
    lat_degree = MathUtility.get_lat_degree(lat, lng, radius)
    lng_degree = MathUtility.get_lng_degree(lat, lng, radius)
    is_return_json = !(lat_degree == 0 || lng_degree == 0)

    # response
    if is_return_json
      datas = Sensor.where(
        sensor_id: sensor_type,
        lat: (lat-lat_degree)..(lat+lat_degree),
        lng: (lng-lng_degree)..(lng+lng_degree)
      )
      json = Jbuilder.encode do |j|
        j.sensor_datas(datas)
      end
      render json: json
    else
      render json: { }
    end
  end

end
