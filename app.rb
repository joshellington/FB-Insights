require 'rubygems'
require 'sinatra'
require './lib/init'

#

FACEBOOK_APP_ID = '128553427233076'
FACEBOOK_APP_SECRET = 'd206f36f5460ea2972f0f95c018cbd56'
FACEBOOK_OAUTH_REDIRECT_URI = 'http://localhost:9393/'
FACEBOOK_OAUTH_SCOPE = 'publish_stream'

before do
  @path = request.env['SCRIPT_NAME']
end

helpers do

  def get_token
    if session[:code].nil?
      redirect FGraph.oauth_authorize_url(FACEBOOK_APP_ID, FACEBOOK_OAUTH_REDIRECT_URI, :scope => FACEBOOK_OAUTH_SCOPE)
    end
  end

  def access_token(code)
    session[:token] = FGraph.oauth_access_token(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, :redirect_uri => FACEBOOK_OAUTH_REDIRECT_URI, :code => code)["access_token"]
  end

end

match '/' do
  if params[:code] && session[:code].nil?
    session[:code] = params[:code]
    access_token(params[:code])
    redirect '/me'
  else
    get_token
  end
end

match '/me' do
  data = FGraph.me(:access_token => session[:token])
  data.inspect
end

match '/me/post/:msg/?' do
  FGraph.publish_feed('me', :message => params[:msg], :access_token => session[:token])
  "Success!"
end