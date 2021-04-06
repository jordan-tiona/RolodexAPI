class AuthController < ApplicationController

    def login
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            token = JWT.encode({user_id: user.id}, secret, 'HS256')
            render json: {user: user, token: token, message: 'Login Successful', status: :ok}
        else
            render json: {message: 'Login failed: incorrect email or password', status: :unauthorized}
        end
    end

    def persist
        if request.headers['Authorization']
            token = JWT.decode(request.headers['Authorization'], secret)
            user_id = token[0]['user_id']
            user = User.find(user_id)
            if user
                render json: {user: user, message: 'Authorized'}
            else
                render json: {error: 'User not found', user_id: user_id}
            end
        end
    end

    private
    def login_params
        params.permit(:email, :password)
    end
end
