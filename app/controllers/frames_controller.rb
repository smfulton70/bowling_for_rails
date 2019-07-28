class FramesController < ApplicationController
def new
  @game = Game.find(params[:game_id])
  @frame = Frame.new
end

def create
  @game = Game.find(params[:game_id])
  @frame = @game.frames.create(frame_params)
  @frame.set_frame_number
  redirect_to game_frame_path(@game, @frame)
end

def show
  @game = Game.find(params[:game_id])
  @frame = Frame.find(params[:id])
end

def edit
  @game = Game.find(params[:game_id])
  @frame = Frame.find(params[:id])
end

def update
  @game = Game.find(params[:game_id])
  @frame = @game.frames.update(frame_params)
  redirect_to game_frame_path(@game, @frame)
end

private
  def frame_params
    params.require(:frame).permit(:ball_one, :ball_two, :ball_three, :frame_number, :frame_score, :spare, :strike)
  end
end
