require 'webrick'

root = File.expand_path '~/public_html'
server = WEBrick::HTTPServer.new :Port => 8080, :DocumentRoot => root





server.mount_proc '/' do |req, res|
  res.content_type = 'text/text'
  res.body = req.path
end

trap 'INT' do server.shutdown end
server.start

