class Game < ApplicationRecord
  has_many :frames

  before_update do

  end

  def calculate_frame_score
    #most recently completed frame
    current_frame = self.frames.last
    # 2nd to most recently completed frame, if there is such a frame
    previous_frame = self.frames[-2]
    if self.frames.length == 1
      current_frame.frame_score = current_frame.get_frame_pin_total
    else
      # in case of strike, add the total pins from BOTH balls rolled
      # in the current frame to the frame score of previous frame.
      if previous_frame.is_strike?
        previous_frame.frame_score += current_frame.get_frame_pin_total
      # in case of spare, add the pins knocked over from first ball
      # rolled in the current frame to the frame score of previous frame.
      elsif previous_frame.is_spare?
        previous_frame.frame_score +=
        current_frame.ball_one
      end
      current_frame.frame_score = previous_frame.frame_score + current_frame.get_frame_pin_total
    end
  end
end
