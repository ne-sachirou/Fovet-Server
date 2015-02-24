class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :destroy]
  before_action :auth_token, only: [:index, :show, :create, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new movie_params
    if @movie.save
      render :show, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit :count, :lat, :long, :uuid, :user_id
    end
end
