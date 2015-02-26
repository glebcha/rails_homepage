class TagController < ApplicationController

  require 'htmlentities'

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name)
    fresh_when :etag => @article, public: true 
  end
end
