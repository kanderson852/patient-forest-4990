class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors.order_by_age
    @average = @actors.average_age
  end
end
