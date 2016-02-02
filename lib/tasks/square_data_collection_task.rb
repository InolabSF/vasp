require 'uri'
require './lib/assets/square_data_collector'


class SquareList
    attr_accessor :square, :count

    def initialize(radius, lat, lng)
      @square = Square.new
      @square.radius = radius
      @square.ambient = 0
      @square.co = 0
      @square.co2 = 0
      @square.humidity = 0
      @square.no2 = 0
      @square.ozone_s = 0
      @square.so2 = 0
      @square.temp_c = 0
      @square.uv = 0
      @square.lat = lat.to_f
      @square.lng = lng.to_f
      @square.pressure = 0

      @count = 0
    end

    def add_data(data)
      data.each do |key, value|
        square_attr = "#{key.downcase}"
        if @square.respond_to?("#{square_attr}=")
          current_value = @square.send(square_attr)
          new_value = current_value + value.to_f
          @square.send("#{square_attr}=", new_value)
        end
      end

      @count = @count + 1
    end

    def include?(lat, lng)
      latitude = lat.to_f
      longitude = lng.to_f
      offset = @square.radius / 2.0
      (latitude  >= @square.lat - offset &&
       latitude  <= @square.lat + offset &&
       longitude >= @square.lng - offset &&
       longitude <= @square.lng + offset)
    end

    def average
      @square.ambient  = @square.ambient / @count
      @square.co       = @square.co / @count
      @square.co2      = @square.co2 / @count
      @square.humidity = @square.humidity / @count
      @square.no2      = @square.no2 / @count
      @square.ozone_s  = @square.ozone_s / @count
      @square.so2      = @square.so2 / @count
      @square.temp_c   = @square.temp_c / @count
      @square.uv       = @square.uv / @count
      @square.pressure = @square.pressure / @count
    end
end


class Tasks::SquareDataCollectionTask

  def self.collect_all
    radius = 0.0025
    all_datas = SquareDataCollector.get_data_from_parse(DateTime.now, DateTime.new(2000, 1, 1))
    square_lists = []

    # sum vasp data into radius x radius square
    all_datas.each do |data|
      is_new_square = true

      lat = data['latitude']
      lng = data['longitude']
      square_lists.each do |square_list|
        if square_list.include?(lat, lng)
          is_new_square = false
          square_list.add_data(data)
          break
        end
      end

      if is_new_square
        square_list = SquareList.new(radius, lat, lng)
        square_list.add_data(data)
        square_lists.push(square_list)
      end
    end

    # update all data
    Square.delete_all
      # calculate average of each square
    square_lists.each do |square_list|
      square_list.average
      square_list.square.save if square_list.square.valid?
    end

  end

end
