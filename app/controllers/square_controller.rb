class SquareController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def get
    do_return_json = true

    radius = params[:radius].to_f
    radius = 0.0025 if radius == nil || radius < 0.0025

#    south = params[:south].to_f
#    north = params[:north].to_f
#    west = params[:west].to_f
#    east = params[:east].to_f
#    do_return_json = false if (!(south.is_a?(Float) || south.is_a?(Fixnum)) ||
#                               !(north.is_a?(Float) || north.is_a?(Fixnum)) ||
#                               !(west.is_a?(Float)  || west.is_a?(Fixnum))  ||
#                               !(east.is_a?(Float)  || east.is_a?(Fixnum)))

    if do_return_json
      squares = Square.where(
        radius: radius
        #lat: south..north,
        #lng: west..east
      )

      json = Jbuilder.encode do |j|
        j.application_code(200)
        j.squares(squares)
      end
      render json: json
    else
      render json: { :application_code => 400 }
    end
  end

end
