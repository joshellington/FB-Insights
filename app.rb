require 'rubygems'
require 'sinatra'
require './lib/init'

#

before do
  @path = request.env['SCRIPT_NAME']
end

match '/' do
  "Hello world."
end