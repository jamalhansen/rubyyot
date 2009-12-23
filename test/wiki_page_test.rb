require 'test_helper'
require 'lib/wiki_page'

class WikiPageTest < Test::Unit::TestCase
  context "Returning a response" do
    setup do
      @page = Rubyyot::WikiPage.new
    end
    
    should "have a status of 200" do
      status, headers, body = @page.build_response("foo")
      assert_equal(200, status)
    end
  end
end