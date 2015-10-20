module MathUtility

  def self.get_distance(lat1, lng1, lat2, lng2)
    return 0 if (!(lat1.is_a?(Float) || lat1.is_a?(Fixnum)) ||
                 !(lng1.is_a?(Float) || lng1.is_a?(Fixnum)) ||
                 !(lat2.is_a?(Float) || lat2.is_a?(Fixnum)) ||
                 !(lng2.is_a?(Float) || lng2.is_a?(Fixnum)))

    y1 = lat1 * Math::PI / 180
    x1 = lng1 * Math::PI / 180
    y2 = lat2 * Math::PI / 180
    x2 = lng2 * Math::PI / 180
    earth_r = 6378140
    deg = Math::sin(y1) * Math::sin(y2) + Math::cos(y1) * Math::cos(y2) * Math::cos(x2 - x1)
    distance = earth_r * (Math::atan(-deg / Math::sqrt(-deg * deg + 1)) + Math::PI / 2) / 1000
  end

  def self.get_lat_degree(lat, lng, mile)
    return 0 if (!(mile.is_a?(Float) || mile.is_a?(Fixnum)))
    distance = self.get_distance(lat, lng, lat+1.0, lng)
    return 0 if distance == 0
    mile / distance
  end

  def self.get_lng_degree(lat, lng, mile)
    return 0 if (!(mile.is_a?(Float) || mile.is_a?(Fixnum)))
    distance = self.get_distance(lat, lng, lat, lng+1.0)
    return 0 if distance == 0
    mile / distance
  end

end
