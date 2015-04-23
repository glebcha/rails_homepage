class PostsController < ApplicationController

  require 'htmlentities'

  def post_params
    params.require(:post).permit(:name, :tag_list) 
  end
  def index
    @index_posts = Post.where(:status => 1).per_page_kaminari(params[:index_posts]).per(5)
    @user = current_user
    if @user != nil
      @username = @user.name
      @posts = @user.posts.take(5)
    end
    fresh_when :etag => @index_posts, public: true 
  end
  def show
    @post = Post.find_by_url(params[:id])
    @name = @post.name
    @id = @post.id
    @current = current_user
    @user = @post.user
    @username = @user.name
    @date = @post.created_at.to_time.strftime('%d.%m.%Y')
    @body = @post.body.html_safe
    @tags = @post.tags
    @attachments = @post.attachments
    @background = @post.background
    
    @post.punch(request)

    fresh_when :etag => @post, public: true 

    rescue Exception
      flash[:notice] = "Такой записи не существует"
      redirect_to :action => 'index'
  end
end