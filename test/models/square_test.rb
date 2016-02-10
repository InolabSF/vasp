require 'test_helper'


describe Square do

  describe '#attributes' do
    it "#attributes are required" do
      Square.new.valid?.must_equal false
    end
  end

end
