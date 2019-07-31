class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new(name: "")
  end

  def create
    @game = Game.new(name: game_params["name"])

    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def update
    @game = Game.find(params[:id])
    @game.save
  end

  def show
    @game = Game.find(params[:id])
  end

  private
  def game_params
    params.require(:game).permit(:name)
  end

end
