require 'rack'
require 'lib/wiki_page'

use Rack::Static, :urls => ["/favicon.ico"]
run Rubyyot::WikiPage.new        
