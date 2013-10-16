require 'json'
require 'webrick'
require 'debugger'
class Session
  def initialize(req)
    # debugger
    
    found_cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
    @cookie = found_cookie.nil? ? {} : JSON.parse(found_cookie.value) 
    
    
    # req.cookies.each do |cookie|
    #   if cookie.name == "_rails_lite_app"
    #     if cookie.value
    #       # @cookie_value = cookie.as_json["value"]
    #       # @cookie = cookie.as_json 
    #       @cookie = JSON.parse(cookie.value)
    #       # @cookie = JSON.parse(cookie.value)
    #     else
    #       @cookie = {}
    #     end
    #   end
    # end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    new_cookie = WEBrick::Cookie.new("_rails_lite_app", @cookie.to_json)
    res.cookies << new_cookie
  end
end
