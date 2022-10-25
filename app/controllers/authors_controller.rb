class AuthorsController < ApplicationController
    def index
        @authors = Author.all
    end

    def show
        @author = Author.find(params[:id])
    end

    def new
        @author = Author.new
    end

    def edit
        @author = Author.find(params[:id])
    end

    def create
        @author = Author.new(article_params)
            
        
        if @author.save
            redirect_to @author
        else
            render 'new'
        end
        #render plain: params[:author].inspect
    end

    private
        def article_params
            params.require(:author).permit(:title, :text)
        end
end
