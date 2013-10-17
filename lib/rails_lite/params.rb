require 'uri'
require 'debugger'

class Params
  def initialize(req, route_params = nil)
    # debugger
    if req.query_string
      @params = parse_www_encoded_form(req.query_string)
    elsif req.body
      # debugger
      @params = parse_www_encoded_form(req.body)
    end
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
    # array.each do |pair|
    #   return_hash[pair[0]] = pair[1]
    # end
    inner_hash = {}
    root_str = ""
    counter = 0
    array.each do |pair|
      if counter == 0
        root_str = parse_root_string(pair[0])
      end
      inner_hash[parse_string(pair[0])] = pair[1]
      counter += 1
    end
    
    return_hash[root_str] = inner_hash
    
    
    return_hash
  end

  def parse_root_string(string)
    string.split(/\]\[|\[|\]/)[0]
  end
  def parse_string(string)
    string.split(/\]\[|\[|\]/)[1]
  end
  
  # def parse_key(key)
  #   
  # end
end
