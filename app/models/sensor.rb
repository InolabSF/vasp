class Sensor < ActiveRecord::Base
  validates_presence_of :type, :lat, :lng, :weight, :timestamp
end
