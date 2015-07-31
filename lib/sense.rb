require 'rest-client'

class Sense
  BASE_URL = 'https://apis.sen.se/v2/'
  def new
    @http_client = RestClient::Resource.new BASE_URL
  end

  def authenticate(auth = {})
    auth.fetch(:username)
    auth.fetch(:password)
  rescue KeyError
    fail ArgumentError, 'Please provide both username and password'
  end

  def authenticated?
    !!@token
  end
end
