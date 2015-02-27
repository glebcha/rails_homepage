class StaticController < ApplicationController

  require 'htmlentities'

  def home
    @firstpost = Post.where(:status => 1).first
    @firstpost_name = @firstpost.name
    @firstpost_text = @firstpost.body.html_safe
    @background = @firstpost.background
    @instagram = Instagram.user_recent_media("262435066", {:count => 1})
    # Octokit
    @client = Octokit::Client.new(access_token: ENV["octokit_access_token"])
    fresh_when :etag => @firstpost, public: true 
  end
  def instagram
    @instagram = Instagram.user_recent_media("262435066", {:count => 20})
    fresh_when :etag => @firstpost, public: true 
  end		
end