require 'test_helper'
require 'json'

class SessionFlowTestTest < ActionDispatch::IntegrationTest
  test "login timeout and meta/logged-in key test" do
    user = users('user_5')
    print user.full_name
    # Not logged in, because of timeout
    get '/users', params: nil,
        headers: { 'X-Api-Key' => user.token }
    assert_response :success
    jdata = JSON.parse response.body
    # Log in
    post '/sessions',
         params: {
           data: {
             type: 'sessions',
             attributes: {
               full_name: user.full_name,
               password: 'password' }}}.to_json,
         headers: { 'Content-Type' => 'application/vnd.api+json' }
    assert_response 201
    jdata = JSON.parse response.body
    token = jdata['data']['attributes']['token']
    refute_equal user.token, token
    # Logged in
    get '/users', params: nil,
        headers: { 'X-Api-Key' => token }
    assert_response :success
    jdata = JSON.parse response.body
  end
end
