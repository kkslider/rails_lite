require 'erb'
require_relative 'params'
require_relative 'session'
require 'active_support/core_ext'
require 'debugger'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = nil)
    @request = req
    @response = res
    @params = Params.new(@request)
    # @already_built_response = false
  end

  def session
    @session ||= Session.new(@request)
    # @session.store_session(@response)
  end

  def already_rendered?
  end

  def redirect_to(url)
    # raise "built response already" if @already_built_response
    return nil if @already_built_response
    
    @response.header['location'] = url
    # @response.header = "Location: #{url}"
    @response.status = 302
    @already_built_response = true
    
    session.store_session(@response)
    
  end

  def render_content(content, type)
    # debugger
    # raise "built response already" if @already_built_response
    return nil if @already_built_response
    
    @response.body = content
    @response.content_type = type
    
    @already_built_response = true
    
    session.store_session(@response)
  end

  def render(template_name)
   new_erb = ERB.new(File.read("views/#{self.class.name.underscore}/#{template_name}.html.erb")).result(binding)
   render_content(new_erb, "text/html")
  end

  def invoke_action(action_name)
    # self.send()
    
  end
end
