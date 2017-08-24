class UsersController < ApplicationController
   before_action :set_user, only: [:edit,:update,:show,:destroy]
   before_action :require_user, except: [:index,:signup,:create]
   before_action :require_same_user, only: [:edit,:update,:destroy]
   def index
    @users = User.paginate(page: params[:page],per_page: 4)
   end
   
   def signup
    @user = User.new
   end    
      
   def create
    #render plain: params[:user].inspect
    @user = User.new(user_params)
     if @user.save
        flash[:success] = "User was successfully created"
        redirect_to signup_path
     else
        render 'signup'
     end
   end
    
   def show
     @user = User.find(params[:id])
   end
    
   def edit
     @user = User.find(params[:id])    
   end    
    
   def update
     @user = User.find(params[:id])   
     if @user.update(user_params)
        flash[:success] = "Your account info was successfully updated"
        redirect_to user_path(@user.id)
     else
         render 'edit'
     end 
   end 
   
   def destroy
     @user = User.find(params[:id])
     @obj = @user.articles
     @obj.each do |article|
     article.destroy
     end 
     @user.destroy
     flash[:success] = "User was successfully deleted"
     redirect_to users_path
   end

   private
    def set_user
     @user = User.find(params[:id])
    end

   def user_params
     params.require(:user).permit(:username,:email,:password)
   end   
   
   def require_same_user
     if current_user != @user
     flash[:danger] = "Page is not found"
     redirect_to user_path(current_user.id) 
     end  
   end  
   
end