class BooksController < ApplicationController
  prepend_before_action :authenticate_user!, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    #@books = Book.all
    paginationNumber = 3
    if user_signed_in?
      paginationNumber = 5
    end
    @books = Book.order('created_at DESC',:id).page(params[:page]).per_page(paginationNumber)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    # @posts = Post.where(["book_id = ?" , params[:id]])
    @posts = Post.where(:book_id => params[:id])

    paginationNumber = 3
    if user_signed_in?
      paginationNumber = 5
    end
    @posts = Post.order('created_at DESC',:id).page(params[:page]).per_page(paginationNumber)
    
    #.order('created_at DESC').page(params[:page]).per_page(5)
  end

  # GET /books/new
  def new
    if user_signed_in?
      @book = Book.new
    else
      redirect_to 
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      begin
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique
        format.html { redirect_to new_book_path, notice: 'Book already exists.' }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author)
    end
end
