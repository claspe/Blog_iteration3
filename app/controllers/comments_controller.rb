class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /posts/:post_id/comments/new
  def new

    post = Post.find(params[:post_id])
    @comment = post.comments.create
    
    respond_to do |format|
       format.html
       format.json { render :xml => @comment }
    end 
  end

  # POST /posts/:post_id/comments
  # POST /posts/:post_id/comments.json
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post , notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
	    format.js 
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /posts/:post_id/comments/1
  # DELETE /posts/:post_id/comments/1.json
  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
