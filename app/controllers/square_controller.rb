class SquareController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def get
    do_return_json = true

    #south = params[:south].to_f
    #north = params[:north].to_f
    #west = params[:west].to_f
    #east = params[:east].to_f
    #do_return_json = false if (!(south.is_a?(Float) || south.is_a?(Fixnum)) || !(north.is_a?(Float) || north.is_a?(Fixnum)) || !(west.is_a?(Float) || west.is_a?(Fixnum)) || !(east.is_a?(Float) || east.is_a?(Fixnum)))

    if do_return_json
      squares = Square.all
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
