class MoviesController < ApplicationController
  include AuthToken
  before_action :set_movie, only: [:show, :destroy, :get_file, :thumbup]
  before_action :auth_token

  # GET /movies
  # GET /movies.json
  def index
    @movies = @user.movies
    render 'index.json'
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    render 'show.json'
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new movie_params
    @movie.uuid = UUIDTools::UUID.random_create
    @movie.user = @user
    @movie.save_file params[:movie][:file]
    if @movie.save
      render 'show.json', status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    raise Forbidden if @movie.user != @user
    @movie.destroy
    head :no_content
  end

  def nearby
    @movies = Movie.nearby params[:lat], params[:long]
    render 'index.json'
  end

  def get_file
    render file: @movie.filename
  end

  def thumbup
    @movie.thumbup
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.where(uuid: params[:id]).first!
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit :lat, :long
  end
end
