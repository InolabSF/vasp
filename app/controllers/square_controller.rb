class SquareController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    # size of square
    radius = params[:radius].to_f
    radius = 0.001 if radius == nil || radius < 0.001

    # range to get
    south = params[:south] ? params[:south].to_f : -90.0
    north = params[:north] ? params[:north].to_f : 90.0
    west = params[:west] ? params[:west].to_f : -180.0
    east = params[:east] ? params[:east].to_f : 180.0

    squares = Square.where(
      radius: radius,
      lat: south..north,
      lng: west..east
    )

    json = Jbuilder.encode do |j|
      j.application_code(200)
      j.squares(squares)
    end
    render json: json
  end

end
