class PostsController < ApplicationController
  before_action :authenticate_user!
    #Create
    def new
    #사용자가 데이터를 입력할 화면
    end
 
    
    def create
    #입력받은 데이터를 실제 DB에 저장할 액션
      @post = Post.new
      @post.title = params[:input_title]
      @post.content = params[:input_content]
      @post.user_id = current_user.id
      @post.save
      
      #Post.create(title: params[:input_title], content: params[:input_content])
      redirect_to "/posts/show/#{@post.id}"
    end
    
    #Read
    def index
    #전체 글 보여주는 화면
      #@posts = Post.all
      @posts = Post.paginate(:page => params[:page]).order('created_at DESC')
      # @search = Post.search do
      #   fulltext params[:search]
      #   paginate:page => params[:page],:per_page => 5
      # end
      # @posts = @search.results
    end
    
    def board
      @posts = Post.all
    end
    
    def show
    #하나의 글을 보여주는 화면
      @post = Post.find(params[:post_id])
    end
    
    #Update
    def edit
      @post = Post.find(params[:post_id])
    end
    
    def update
    #실제 DB에 반영
      @post = Post.find(params[:post_id])
      @post.update_attributes(title: params[:input_title], content: params[:input_content])
      redirect_to "/posts/show/#{@post.id}"
    end
    
    #Delete
    def destroy
      @post = Post.find(params[:post_id])
      @post.destroy
      redirect_to '/posts/index'
    end
    
    def service1 #자주묻는질문
    end
    def service2 #상담&문의
    end

    # 검색기능
    def search
      @posts = Post.search do
        keywords params[:query]
        # fulltext 
      end.results
      
      respond_to do |format|
        format.html { render :action => "board"}
        format.xml {render :xml => @posts}
      end
    end
end
