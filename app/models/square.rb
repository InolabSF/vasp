class Square < ActiveRecord::Base
  validates_presence_of :ambient, :co, :co2, :humidity, :no2, :ozone_s, :so2, :temp_c, :uv, :lat, :lng, :radius, :pressure, :lat, :lng
end
