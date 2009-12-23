require 'lib/page_builder'

module Rubyyot
  class WikiPage
    def call(env)
      req = Rack::Request.new(env)
      build_response(req.path)
    end 
    
    def build_response(path)
      builder = Rubyyot::PageBuilder.new
      response_body = builder.build(path)
      
      headers = {"Content-Type" => "text/html"}
      headers["Content-Length"] = response_body.length.to_s

      [200, headers, response_body] 
    end
  end   
end