class BlogsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
      end
      format.json do
        render :json => Blog.all.to_json
      end
    end
  end
end
