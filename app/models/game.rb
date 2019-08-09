class Game < ApplicationRecord
  has_many :frames

  def calculate_frame_scores
    @frames = self.frames
    puts @frames
    for i in 0..9
      if i <= 8
        next_frame = @frames[i + 1]
      end
      if i <= 7
        two_frames_future = @frames[i + 2] if @frames[i + 2]
      end
      if i == 0
        @frames[i].update({frame_score: @frames[i].ball_one + @frames[i].ball_two})
      else
        @frames[i].update({frame_score: @frames[i - 1].frame_score + @frames[i].ball_one + @frames[i].ball_two + (@frames[i].ball_three ? @frames[i].ball_three : 0)})
      end
      if @frames[i].spare == true && next_frame
        @frames[i].update({frame_score: @frames[i].frame_score + next_frame.ball_one})
      end
      if @frames[i].strike == true && @frames[i].frame_number < 9
        if next_frame.strike == true
          @frames[i].update({frame_score: @frames[i].frame_score + 10 + two_frames_future.ball_one})
        else
          @frames[i].update({frame_score: @frames[i].frame_score + next_frame.ball_one + next_frame.ball_two})
        end
      elsif @frames[i].strike == true && @frames[i].frame_number == 9
        @frames[i].update({frame_score: @frames[i].frame_score + next_frame.ball_one + next_frame.ball_two})
      end
    end
  end
end
