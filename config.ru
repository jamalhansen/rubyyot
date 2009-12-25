require 'rack'
require 'lib/wiki_page'

# this is the location of the git repository with the wiki data
repo_path = "~/working/rubyyot-wiki-test"

use Rack::Static, :urls => ["/favicon.ico"]
run Rubyyot::WikiPage.new(repo_path)        
