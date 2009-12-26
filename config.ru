require 'rack'
require 'lib/wiki_page'

# this is the location of the git repository with the wiki data
repo_path = "~/git/rubyyot-wiki"

use Rack::Static, :urls => ["/favicon.ico"]
run Rubyyot::WikiPage.new(repo_path)        
