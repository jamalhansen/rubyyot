$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'grit'))
require 'grit'

module Rubyyot
  class PageBuilder
    def initialize
      @repo_path = "~/working/rubyyot-wiki-test"
      @repository = Grit::Repo.new(@repo_path)
    end
    
    def build(route)
      data = find(route[1..-1])
      "#{route} #{data}"
    end
    
    def find(name)
      blob = (@repository.tree/name)
      raise Rubyyot::PageNotFound.new if blob.nil?
      blob.data
    end
  end
end