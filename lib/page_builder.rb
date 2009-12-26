$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'grit', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'flannel', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'diff-lcs', 'lib'))
require 'diff/lcs'
require 'grit'
require 'flannel'

module Rubyyot
  class PageBuilder
    def initialize(repo_path)
      @repo_path = repo_path
      @repository = Grit::Repo.new(@repo_path)
    end
    
    def build(route)
      route_name = route[1..-1]
      data = find(route[1..-1])
      content = "#{Flannel.quilt(data)}"
      wrap_in_layout(content, route_name)
    end
    
    def find(name)
      blob = (@repository.tree/name)
      raise Rubyyot::PageNotFound.new if blob.nil?
      blob.data
    end
    
    def wrap_in_layout(content, route_name)
      %Q{<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
      <title>
      Rubyyot.com - #{route_name}
      </title>
      </head>
      <body>
      #{content}
      </body>
      </html>}
    end
  end
end