require 'uri'
require 'debugger'

class Params
  def initialize(req, route_params = nil)
    # debugger
    @params = parse_www_encoded_form(req.query_string)
  end

  def [](key)
    @params[key]
  end

  def to_s
    # debugger
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    # debugger
    return_hash = {}
    array = URI.decode_www_form(www_encoded_form)
    array.each do |pair|
      return_hash[pair[0]] = pair[1]
    end
    return_hash
  end

  def parse_key(key)
  end
end
