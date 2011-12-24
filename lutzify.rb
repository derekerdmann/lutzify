require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'

get "/" do
  haml :index, format: :html5
end

get "/css" do
  scss :style, style: :expanded
end
