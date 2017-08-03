class ArticlesController < ApplicationController
    
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

    # INDEX
    def index
        @articles = Article.all 
    end

    # EDIT/UPDATE /articles/:id GET
    def edit
        @article = Article.find(params[:id])
    end

    # GET /articles/:id
    def show
        @article = Article.find(params[:id])
    end
    
    # CREATE /articles/new GET
    def new
        @article = Article.new
    end

    # CREATE /articles/new POST
    def create
        @article = Article.new(article_params)

        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    # UPDATE AND SAVE /articles/:id POST
    def update 
        @article = Article.find(params[:id])
        
        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end 
    end

    # DELETE
    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    # method that makes article params accessible
    private
        def article_params
            params.require(:article).permit(:title, :text)
        end

end
