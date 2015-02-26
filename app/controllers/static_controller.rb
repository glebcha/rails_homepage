class StaticController < ApplicationController

  require 'htmlentities'

  def home
    @firstpost = Post.where(:status => 1).first
    @firstpost_name = @firstpost.name
    @firstpost_text = @firstpost.body.html_safe
    @background = @firstpost.background
    @instagram = Instagram.user_recent_media("262435066", {:count => 1})
    # Octokit
    @client = Octokit::Client.new(access_token: "4476426f2394e4174655057b13cfd9a9ec10f665")
    fresh_when :etag => @firstpost, public: true 
  end		
end