require 'test_helper'
require 'lib/page_builder'

class PageBuilderTest < Test::Unit::TestCase
  context "Building a Page" do
    setup do
      @builder = Rubyyot::PageBuilder.new
    end
    
    should "include the location" do
      out = @builder.build("/cheese")
      assert_match("cheese", out)
    end
  end
end