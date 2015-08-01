require 'rest-client'

class Sense
  BASE_URL = 'https://apis.sen.se/v2'

  class AuthenticationError < StandardError; end

  attr_reader :http, :token

  def initialize
    @http = RestClient::Resource.new(BASE_URL)
  end

  def authenticate(auth = {})
    auth = { username: auth.fetch(:username), password: auth.fetch(:password) }
    response = http['user/api_key/'].post auth
    @token = JSON.parse(response)['token']
    @http = RestClient::Resource.new(BASE_URL, headers: {Authorization: "Token #{token}"})
    true
  rescue RestClient::BadRequest
    false
  rescue KeyError
    fail ArgumentError, 'Please provide both username and password'
  end

  def authenticated?
    !!@token
  end
end
