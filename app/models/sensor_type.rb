class SensorType < ActiveHash::Base
  self.data = [
    { :id => 1,  :name => 'humidity' },
    { :id => 2,  :name => 'co' },
    { :id => 3,  :name => 'living_risk_index' }
  ]
end
