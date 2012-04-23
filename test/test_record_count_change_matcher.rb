require File.expand_path("#{File.dirname(__FILE__)}/helper")

class TestRecordCountChangeMatcher < Test::Unit::TestCase
  def create_blog(n = 1)
    Blog.create :title => "blog title #{n}"
  end
  
  def destroy_blog
    Blog.first.destroy
  end
  
  subject { } # Shoulda likes a subject, even though this test doesn't use one

  context "create_record" do
    context "with created record" do
      setup { create_blog }
      should create_record Blog
    end
    
    context "without created record" do
      setup { }
      should_not create_record Blog
    end
  end
  
  context "destroy_record" do
    setup { create_blog }
    
    context "with destroyed record" do
      setup { destroy_blog }
      should destroy_record Blog
    end
    
    context "without destroyed record" do
      setup { }
      should_not destroy_record Blog
    end
  end
  
  context "change_record_count" do
    setup do
      create_blog 1
      create_blog 2
    end
    
    context "with no record changes" do
      context "not change_record_count.for(:blog) and not change_record_count.for(:comment)" do
        should_not change_record_count.for(:blog)
        should_not change_record_count.for(:comment)
      end
    end
    
    context "with created record" do
      context "change_record_count.for(:blog).by(1)" do
        setup { create_blog 3 }
        should change_record_count.for(:blog).by(1)
      end
      
      context "change_record_count.for(Blog).by(1)" do
        setup { create_blog 3 }
        should change_record_count.for(Blog).by(1)
      end
      
      context "change_record_count.for(Blog)" do
        setup { create_blog 3 }
        should change_record_count.for(Blog)
      end
      
      context "not change_record_count.for(Blog).by(2)" do
        setup { create_blog 3 }
        should_not change_record_count.for(Blog).by(2)
      end
      
      context "not change_record_count.for(Blog).by(-1)" do
        setup { create_blog 3 }
        should_not change_record_count.for(Blog).by(-1)
      end
      
      context "not change_record_count.for(Comment)" do
        setup { create_blog 3 }
        should_not change_record_count.for(Comment)
      end
    end
    
    context "with 2 created records" do
      context "change_record_count.for(:blog).by(2)" do
        setup { create_blog 3 and create_blog 4 }
        should change_record_count.for(:blog).by(2)
      end
      context "not change_record_count.for(:blog).by(1)" do
        setup { create_blog 3 and create_blog 4 }
        should_not change_record_count.for(:blog).by(1)
      end
      context "not change_record_count.for(:blog).by(-2)" do
        setup { create_blog 3 and create_blog 4 }
        should_not change_record_count.for(:blog).by(-2)
      end
    end

    context "with destroyed record" do
      context "change_record_count.for(:blog).by(-1)" do
        setup { destroy_blog }
        should change_record_count.for(:blog).by(-1)
      end
      
      context "change_record_count.for(Blog).by(-1)" do
        setup { destroy_blog }
        should change_record_count.for(Blog).by(-1)
      end
      
      context "change_record_count.for(Blog)" do
        setup { destroy_blog }
        should change_record_count.for(Blog)
      end
      
      context "not change_record_count.for(Blog).by(-2)" do
        setup { destroy_blog }
        should_not change_record_count.for(Blog).by(-2)
      end
      
      context "not change_record_count.for(Blog).by(1)" do
        setup { destroy_blog }
        should_not change_record_count.for(Blog).by(1)
      end
      
      context "change_record_count.for(:blog).by(-1) and not change_record_count.for(Comment)" do
        setup { destroy_blog }
        should change_record_count.for(:blog).by(-1)
        should_not change_record_count.for(Comment)
      end
    end
    
    context "with 2 destroyed records" do
      context "change_record_count.for(:blog).by(-2)" do
        setup { destroy_blog and destroy_blog }
        should change_record_count.for(:blog).by(-2)
      end
      context "not change_record_count.for(:blog).by(-1)" do
        setup { destroy_blog and destroy_blog }
        should_not change_record_count.for(:blog).by(-1)
      end
      context "not change_record_count.for(:blog).by(2)" do
        setup { destroy_blog and destroy_blog }
        should_not change_record_count.for(:blog).by(2)
      end
    end
    
  end
end
