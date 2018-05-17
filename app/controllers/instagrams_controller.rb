class InstagramsController < ApplicationController
    def index
        @users=User.all
    end
    def new
        @instagram=Instagram.new
    end
    def create
        @instagram=Instagram.new(instagram_params)
        User.all.delete_all
        if @instagram.save
            username=@instagram.username
            password=@instagram.password
            insta_url=@instagram.insta_url
            #call instance of Crawl (In Model)
            crawl=Crawl.new
            crawl.login_instagram(username, password)
            crawl.find_user(insta_url)
            crawl.crawl_followers
            @users=User.all
            render 'index'
        end
    end
    private def instagram_params
        params.require(:instagram).permit(:username,:password,:insta_url)
    end
end
