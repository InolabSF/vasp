class Air < ActiveRecord::Base
  validates_presence_of :south, :north, :west, :east, :SO2, :Ozone_S
end
