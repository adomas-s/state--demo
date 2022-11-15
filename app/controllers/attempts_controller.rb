class AttemptsController < ApplicationController
  def create
    if session[:current_player_id]
      game = Game.find(params[:game_id])
      player = Player.find(session[:current_player_id])

      guess = params.dig(:attempt, :value)
      attempt = Attempt.create!(
        game: game,
        player: player,
        value: guess
      )
      if game.passcode == guess
        render plain: "YOU WON. The passcode is #{guess}"
      else
        redirect_to game
      end
    else
      render plain: "Unauthorized", status: :unauthorized
    end
  end
end
