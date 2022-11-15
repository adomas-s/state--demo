class GamesController < ApplicationController
  def new
  end

  def create
    if session[:current_player_id]
      game = Game.create!(passcode: params.dig(:game, :passcode))
      redirect_to game
    else
      redirect_to [:new, :session]
    end
  end

  def show
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      @game = Game.find(params[:id])
      @attempts = Attempt.where(game_id: params[:id])
    else
      redirect_to [:new, :session]
    end
  rescue ActiveRecord::RecordNotFound
    session[:current_player_id] = nil
    redirect_to root_path
  end

  def index
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      @games = Game.all.order(:id)
    else
      redirect_to [:new, :session]
    end
  rescue ActiveRecord::RecordNotFound
    session[:current_player_id] = nil
    redirect_to root_path
  end
end
