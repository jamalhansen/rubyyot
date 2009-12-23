module Rubyyot
  class WikiPage
    def call(env)
      response_body = "Wiki Wiki"

      headers = {"Content-Type" => "text/html"}
      headers["Content-Length"] = response_body.length.to_s

      [200, headers, response_body] 
    end                 
  end   
end