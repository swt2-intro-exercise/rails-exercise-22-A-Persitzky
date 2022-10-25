class AuthorsController < ApplicationController
    def index
        @authors = Author.all
    end

    def show
        @author = Author.find(params[:id])
    end

    def new
    end

    def create
        @author = Author.new(article_params)
            
        
        @author.save
        redirect_to @author
        #render plain: params[:author].inspect
    end

    private
        def article_params
            params.require(:author).permit(:title, :text)
        end
end
