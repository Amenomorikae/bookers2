class BooksController < ApplicationController
	before_action :authenticate_user!
	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end
	def new
		@book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end
	def create
		@book = Book.new(post_book_params)
		@book.user = current_user
	    if @book.save
	    	flash[:notice] = "successfully"
	       	redirect_to book_path(@book)
	    else
	    	@books = Book.all
	    	@user = current_user
	    	render action: :index
	    end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(post_book_params)
	      flash[:notice] = "successfully"
	      redirect_to book_path(@book)
	    else
	      @books = Book.all
	      render action: :edit
	    end
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
	end
	def destroy
		@book = Book.find(params[:id])
	    @book.destroy
	    redirect_to books_path
	end

	private
	def post_book_params
		params.require(:book).permit(:title, :body)
	end
end
