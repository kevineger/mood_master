class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, only: [:new, :create,:edit, :update, :destroy, :like, :unlike]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    4.times {@post.contents.build}
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params.except(:tags))
    tags = post_params[:tags].split(',')
    @post.user = current_user

    respond_to do |format|
      if @post.save
        @post.add_tags_with_check(tags)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @post.like(current_user)
    redirect_to post_url(@post)
  end

  def unlike
    @post.unlike(current_user)
    redirect_to post_url(@post)
  end

  def liked
    @posts = Post.where(id:  Likes.where(user_id: current_user.id).map{|likes| likes.post_id})
  end

  def search
    @tags = params[:tags].split(',')
    @posts = Post.tag_search(@tags)
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :tags,:main_image, contents_attributes: [:name, :link])
    end
end
