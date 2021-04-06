class ClientsController < ApplicationController
    
    #Renders single client of user if authorized
    def show
        user = authenticate
        if user
            client = Client.find(params[:id])
            if client.clientof == user.id
                render json: {client: client, message: 'Success', status: :ok}
            else
                render json: {message: 'Client does not belong to user', status: :unauthorized}
            end
        else
            render json: {message: 'Invalid token', status: :unauthorized}
        end
    end

    #Renders list of clients belonging to authorized user
    def index
        user = authenticate
        if user
            clients = Client.where('clientof = ?', user.id)
            render json: {clients: clients, message: 'Success', status: :ok}
        else
            render json: {message: 'Invalid token', status: :unauthorized}
        end
    end

    def update
        user = authenticate
        if user
            client = Client.find(params[:id])
            if client.clientof == user.id
                client.update(
                    firstname: params[:client][:firstname],
                    lastname: params[:client][:lastname],
                    dateofbirth: Date.parse(params[:client][:dateofbirth]),
                    address: params[:client][:address],
                    state: params[:client][:state],
                    zipcode: params[:client][:zipcode],
                    phonenumber: params[:client][:phonenumber],
                    lastappointment: params[:client][:lastappointment],
                    nextappointment: params[:client][:nextappointment],
                    notes: params[:client][:notes]
                )
                render json: {client: client, message: 'Success', status: :ok}
            else
                render json: {message: 'Client does not belong to user', status: :unauthorized}
            end
        else
            render json: {message: 'Invalid token', status: :unauthorized}
        end
    end

    def create
        user = authenticate
        if user
            client = Client.create(
                firstname: params[:client][:firstname],
                lastname: params[:client][:lastname],
                dateofbirth: params[:client][:dateofbirth],
                address: params[:client][:address],
                city: params[:client][:city],
                state: params[:client][:state],
                zipcode: params[:client][:zipcode],
                phonenumber: params[:client][:phonenumber],
                lastappointment: params[:client][:lastappointment],
                nextappointment: params[:client][:nextappointment],
                notes: params[:client][:notes],
                clientof: user.id
            )
            render json: {client: client, message: 'Success', status: :ok}
        else
            render json: {message: 'Invalid token', status: :unauthorized}
        end
    end

    def destroy
        user = authenticate
        if user
            client = Client.find(params[:id])
            if client.clientof == user.id
                client.destroy()
                render json: {message: 'Success', status: :ok}
            else
                render json: {message: 'Client does not belong to user', status: :unauthorized}
            end
        else
            render json: {message: 'Invalid token', status: :unauthorized}
        end
    end

    private
    #Check JWT token
    def authenticate
        if request.headers['Authorization']
            token = JWT.decode(request.headers['Authorization'], secret)
            user_id = token[0]['user_id']
            user = User.find(user_id)
            if user
                return user
            else
                return nil
            end
        end

        return nil
    end
end