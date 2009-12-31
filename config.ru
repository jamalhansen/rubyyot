require 'rack'
require 'lib/google_analytics'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'wiki/wiki_page'

def set_repo_path
  return ENV['RUBYYOT_WIKI_PATH'] if ENV['RUBYYOT_WIKI_PATH'] != nil
  "~/git/rubyyot-wiki.git"
end 

# this is the location of the git repository with the wiki data
repo_path = set_repo_path

use Rack::CommonLogger
use Rack::ContentLength
use Rack::Static, :urls => ["/favicon.ico", "/css/*"]
use Rack::GoogleAnalytics, 'UA-5919945-1'
run Rubyyot::WikiPage.new(repo_path)       

