
require File.join(File.dirname(__FILE__), 'helper')

class TestRespondWithJson < ActionController::TestCase
  context "blogs controller" do
    setup do
      @controller = BlogsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end
    
    context ":index.json and block test" do
      setup do
        get :index, :format => 'json'
        @expected_title = 'blog post 1'
      end
      should respond_with_json { |json| json.first['blog']['title'] == @expected_title}
    end
    
    context ":index.json and exact match" do
      setup do
        get :index, :format => 'json'
      end
      should respond_with_json.exactly(['blog' => {'id' => 1, 'title' => 'blog post 1', 'created_at' => '2011-04-11T07:16:33Z', 'updated_at' => '2011-04-11T07:16:33Z'}])
    end
    
    context ":index.json and exact block match" do
      setup do
        get :index, :format => 'json'
      end
      should respond_with_json.exactly{ |json| JSON.parse(Blog.all.to_json)}
    end
    
    context ":index and should_not response_with_json" do
      setup do
        get :index
      end
      should_not respond_with_json
    end
    
  end
end
