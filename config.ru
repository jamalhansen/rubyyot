require 'rack'
require 'lib/google_analytics'
require 'lib/disqus'
require 'lib/layout'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'grit', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'flannel', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'diff-lcs', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'mime-types', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'wonki', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vendor', 'gems', 'rack-cache', 'lib'))

require 'wonki'
require 'rack/cache'

use Rack::CommonLogger

use Rack::Cache,
  :verbose     => true,
  :metastore   => 'file:~/cache/rubyyot.com/meta',
  :entitystore => 'file:~/cache/rubyyot.com/entity'

use Rack::ContentLength
use Rack::Static, :urls => ["/favicon.ico", "/css/*", "/javascript/*"]
use Rack::Disqus, 'rubyyot'
use Rack::GoogleAnalytics, 'UA-5919945-1'
use Rack::Layout
run Wonki::WikiPage.new("~/git/rubyyot-wiki.git", :max_age => 3600)       

