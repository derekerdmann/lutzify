require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'

get "/" do

  @host = "http://#{request.host}"
  if request.port != 80
    @host += ":#{request.port}"
  end

  haml :index, format: :html5
end

get "/css" do
  scss :style, style: :expanded
end

get "/img" do
  content_type "image/jpeg"

  image_dir = Dir.new( "images" )
  image = image_dir.reject{ |f| File.directory? f }.map{ |f| f }.sample

  File.open( "images/#{image}" ) do |image|
    image.readlines
  end
end

get "/js" do
  coffee :lutzify
end
