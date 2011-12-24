require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'

# Gets the correct hostname based on the request
def host
  host = "#{request.scheme}://#{request.host}"
  if request.port != 80
    host += ":#{request.port}"
  end
  return host
end


get "/" do
  @host = host
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
  @host = host
  content_type "application/javascript"
  erb :"lutzify.js"
end
