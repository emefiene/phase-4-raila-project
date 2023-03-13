class UsersController < ApplicationController
   skip_before_action :authorized_user, only: [:create]
   
    def index
      render json: User.all,  status: :ok

      end
  
      def show
         #  user = User.find(params[:id])
          render json: current_user, status: :ok
      end
      
      def allUsers
         render json: User.all,  status: :ok
      end

      def dynamic
          user = User.find(params[:id])
          render json: user, status: :ok
      end
      
      # def welcome
      #     render json: {hi: 'welcome'}
      # end
      
      # def welcome_name
      #     render json: {hi: "welcome #{params[:name]}"}
      # end
  
      def create
         user = User.create!(params_user)
         render json: user, status: :ok
      end

      def update
         user = User.find(params[:id])
         if user.id == current_user.id
           user.update(user_permit)
           render json: user, status: :accepted
           else
            render json: {Error: ":  Not Authorized User"}, status: :not_found
         end

      end
         
  
      # def update
      #    user = User.find(params[:id])
      #    user.update!(user_permit)
      #    render json: user, status: :accepted
      # end
  
      def destroy
          user = User.find(params[:id])
          user.destroy
          head :no_content
      end
    
  
      private
    
  
      def params_user
         params.permit(:name, :email, :password, :password_confirmation, :age, :address, :image)
      end
      def user_permit
         params.permit(:name, :email,:age, :address, :image, :password, :password_confirmation)
      end
end

