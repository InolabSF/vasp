class User < ActiveRecord::Base
  validates_presence_of :air, :lat, :lng, :uuid, :name, :timestamp
end
