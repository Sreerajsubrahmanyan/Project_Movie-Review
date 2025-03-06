class MoviesController < ApplicationController
  def index
    @movies = if params[:search]
                Movie.where("title LIKE ? OR genre LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
              else
                Movie.all
              end
  end

  def show
    @movie = Movie.find(params[:id])
    @review = Review.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie added successfully!"
    else
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :genre)
  end
end
