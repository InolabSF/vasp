class AirController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def get
    do_return_json = true
    application_code = 200

    if do_return_json
      airs = Air.all
      json = Jbuilder.encode do |j|
        j.application_code(application_code)
        j.airs(airs)
      end
      render json: json
    else
      render json: { :application_code => application_code }
    end
  end

end
