class UsersController < ApplicationController

    def index
        render json: {message: 'Hello'}
    end
    
    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user = User.create(user_params)
        if user.valid?
            user = user
            token = JWT.encode({user_id: user.id}, secret, 'HS256')
            render json: {user: user, token: token, status: :ok}
        else
            render json: {errors: 'Error creating user'}
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
    end

    private
    def user_params
        params.permit(:email, :password)
    end
end
