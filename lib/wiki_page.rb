require 'lib/page_builder'
require 'lib/page_not_found'

module Rubyyot
  class WikiPage
    def initialize(repo_path)
      @repo_path = repo_path
    end
    
    def call(env)
      req = Rack::Request.new(env)
      build_response(req.path)
    end 
    
    def build_response(path)
      path = "/home" if path == "/"
      builder = Rubyyot::PageBuilder.new(@repo_path)
      
      begin
	response_body = builder.build(path)
	status = 200
      rescue Rubyyot::PageNotFound
	response_body = "Page Not Found"
	status = 404
      rescue 
	response_body = "Server Error"
	status = 502
      end
      
      headers = {"Content-Type" => "text/html"}
      headers["Content-Length"] = response_body.length.to_s

      [status, headers, response_body] 
    end
  end   
end