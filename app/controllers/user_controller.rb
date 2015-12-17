require './lib/assets/math_utility'


class UserController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def get
    # get latitude, longitude
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    radius = params[:radius].to_f

    # calculate distance of latitude and longitude degree
    lat_degree = MathUtility.get_lat_degree(lat, lng, radius)
    lng_degree = MathUtility.get_lng_degree(lat, lng, radius)
    do_return_json = !(lat_degree == 0 || lng_degree == 0)
    application_code = do_return_json ? 200 : 400

    # response
    if do_return_json
      start_date = 12.hours.ago
      end_date = DateTime.now

      users = User.where(
        lat: (lat-lat_degree)..(lat+lat_degree),
        lng: (lng-lng_degree)..(lng+lng_degree),
        timestamp: start_date..end_date
      )

      json = Jbuilder.encode do |j|
        j.application_code(application_code)
        j.users(users)
      end
      render json: json
    else
      render json: { :application_code => application_code }
    end
  end

  def post
    uuid = params[:uuid]
    name = params[:name]
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    air = params[:air].to_i
    unless name || uuid || lat || lng || air
      render json: { :application_code => 400 }
      return
    end

    user = User.where(uuid: uuid).take
    user = User.new unless user
    user.lat = lat
    user.lng = lng
    user.air = air
    user.name = name
    user.uuid = uuid
    user.timestamp = DateTime.now
    if user.valid?
      user.save
      render json: { :application_code => 200 }
    else
      render json: { :application_code => 400 }
    end
  end

end
