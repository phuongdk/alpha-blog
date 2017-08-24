class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit,:update,:show,:destroy]
    before_action :require_user, except: [:home,:index,:show]
    before_action :require_same_user, only: [:edit,:update,:destroy]
    def home
    end 
    
    def index
    @articles = Article.paginate(page: params[:page],per_page: 4)
    end    
    
    def new
     @article = Article.new
     @article.user_id = current_user.id 
    end
    
    def create
    # render plain: params[:article].inspect
     @article = Article.new(article_params)
     @article.user_id = current_user.id 
     if @article.save
        flash[:success] = "Article was successfully created"
        redirect_to article_path(@article)    
     else
        render 'new'
     end    
    end    
    
    def show
    end    
    
    def edit
    end    
    
    def update
     if @article.update(article_params)
        flash[:success] = "Article was successfully updated"
        redirect_to article_path(@article)  
     else
         render 'edit'
     end 
    end    
    
    def destroy
     @article.destroy
     flash[:success] = "Article was successfully deleted"
     redirect_to user_path(@article.user.id)
    end    
    
    private
    def set_article
     @article = Article.find(params[:id])
    end
    
    def article_params
     params.require(:article).permit(:title,:description)
    end    
    
    def require_same_user
     if current_user != @article.user
     flash[:danger] = "404 Page is not found"
     redirect_to user_path(current_user.id) 
     end  
    end  
    
end    