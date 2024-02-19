class UsersController < ApplicationController
    before_action :require_logged_out
    def new
        @user = User.new
        render :new
    end

    def create
        user = User.new(user_params)
        if user.save
            login(user)
            redirect_url cats_url
        else
            render json: user.errors.full_messages
        end
    end


    private

    def user_params
        params.require(user).permit(:username, :password)
    end
end
