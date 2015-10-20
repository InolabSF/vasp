class Sensor < ActiveRecord::Base
  validates_presence_of :type, :lat, :lng, :weight, :timestamp
  self.inheritance_column = :_type_disabled
end
