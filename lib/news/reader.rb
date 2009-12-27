module Rubyyot
  class Reader
    def initialize(app)
      @app = app
    end
    
    def call(env)
      require 'rubygems'
      require 'hpricot'
      require 'open-uri'

      place_holder = "#News#"
      
      status, headers, response = @app.call(env)

      return [status, headers, response] unless status == 200
      
      if response.include?(place_holder)
	news = get_news "http://blog.rubyyot.com/tag/rubyyot/feed/rss"

	#response_body = ""
	#response.each { |part| response_body += part
	response = response.sub(place_holder, news)
      end


      [status, headers, response]
    end
    
    def get_news url
      news = ""
      begin
	doc = Hpricot.XML(open(url))

	(doc/"item").each do |item|
	  link = (item/"link").inner_html
	  description = (item/"description").inner_html
	  title = (item/"title").inner_html
	  news << "<li><h4><a href='#{link}'>#{title}<a></h4>#{description}</li>"
	end
      rescue

      end
      
      news = "There is no new news" unless news
      news
    end
  end
end
