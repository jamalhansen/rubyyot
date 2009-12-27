$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems', 'grit', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems', 'flannel', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems', 'diff-lcs', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems', 'mime-types', 'lib'))

require 'mime/types'
require 'grit'
require 'flannel'
require 'erb'

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
      file = File.read("template.html.erb")
      post_template = ERB.new(file, 0, "%<>")
      post_template.result binding
    end
  end
end