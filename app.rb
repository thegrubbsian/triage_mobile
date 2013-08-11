require "rubygems"
require "sinatra"
require "sinatra/cross_origin"

set :public_folder, "www"

get "/" do
  File.read(File.join("www", "index.html"))
end
