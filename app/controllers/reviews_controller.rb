class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
  
    if @review.save
      redirect_to movie_path(@movie), notice: "Review added!"
    else
      flash[:alert] = "Please fill in all fields correctly."
      redirect_to movie_path(@movie)
    end
  rescue ActionController::ParameterMissing
    flash[:alert] = "Invalid review submission."
    redirect_to movie_path(@movie)
  end
  

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_path(@movie), notice: "Review deleted successfully!"
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
