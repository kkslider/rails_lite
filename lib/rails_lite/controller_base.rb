require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = nil)
    @request = req
    @response = res
    @params = route_params
  end

  def session
  end

  def already_rendered?
  end

  def redirect_to(url)
    raise "built response already" if @already_built_response
    
    @response.header['location'] = url
    # @response.header = "Location: #{url}"
    @response.status = 302
    @already_built_response = true
    # @response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
  end

  def render_content(content, type)
    raise "built response already" if @already_built_response
    @response.body = content
    @response.content_type = type
    
    @already_built_response = true
  end

  def render(template_name)
    # file = File.read(views/#{self.class}/#{template_name}.html.erb)
    new_erb = ERB.new(File.read(views/#{self.class}/#{template_name}.html.erb))
  end

  def invoke_action(name)
  end
end
