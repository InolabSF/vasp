require 'test_helper'


describe SquareController do
  before {
  }

  it "#GET /square - return all squares" do
    get :get
    res = JSON.parse(response.body)
    res['application_code'].must_equal 200
    res['squares'].must_be_kind_of Array
  end
end
