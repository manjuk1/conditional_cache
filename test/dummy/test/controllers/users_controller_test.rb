require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    usr = User.create!
    state = State.create!
    city = City.create!(state_id: state.id)
    address = Address.create!(user_id: usr.id, city_id: city.id)
  end

  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get not_modified response" do
    get users_index_url
    etag = response.etag
    assert_response :success
    get users_index_url, headers: { "If-None-Match": etag }
    assert_response :not_modified
  end

end
