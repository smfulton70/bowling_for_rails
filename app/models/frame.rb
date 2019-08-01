class Frame < ApplicationRecord
  belongs_to :game
  validates :ball_one, :ball_two, presence: true

  before_create do
    if self.game.frames
      if self.game.frames.length >= 1 # If at least one frame has been saved to database...
        @one_frame_ago = self.game.frames[-1] # the last frame saved to database is assigned to @one_frame_ago
        if self.game.frames.length >= 2
          @two_frames_ago = self.game.frames[-2]
        end
      end
      if (@two_frames_ago && @two_frames_ago.strike == true) && (@one_frame_ago.strike == true)
        @two_frames_ago.update({frame_score: @two_frames_ago.frame_score + 20})
        if self.frame_number == 10
          @two_games_ago.update({frame_score: @two_frames_ago.frame_score + 20})
          @one_frame_ago.update({frame_score: @two_frames_ago.frame_score + 30})
        else
          @one_frame_ago.update({frame_score: @two_frames_ago.frame_score + 10})
        end
      end
      if @one_frame_ago && @one_frame_ago.spare == true
         @one_frame_ago.update({frame_score: @one_frame_ago.frame_score + self.ball_one})
      end
    else
      self.frame_score = get_frame_pin_total
    end
    self.strike = true if ball_one == 10
    self.spare = true if ball_one != 10 && get_frame_pin_total == 10
    self.frame_number = self.game.frames.length + 1
    self.frame_score = (@one_frame_ago ? @one_frame_ago.frame_score : 0) + get_frame_pin_total
  end

  def bowl
    ball_one = roll_ball(11)
    if ball_one != 10
      ball_two = roll_ball(11 - ball_one)
    end
    set_frame_number
    set_frame_score
  end

  def bowl_10th
    ball_one = roll_ball(11)
    if ball_one != 10
      ball_two = roll_ball(11 - ball_one)
      if ball_one + ball_two == 10
        ball_three = roll_ball(11 - ball_two)
      end
    else
      ball_two = roll_ball(11)
      if ball_two != 10
        ball_three = roll_ball(11 - ball_two)
      else
        ball_three = roll_ball(11)
      end
    end
    set_frame_number
    set_frame_score
    @final_score = self.game.calculate_frame_score
    puts "Your final score is #{@final_score}"
    puts ""
  end

  def roll_ball(number)
    rand(number)
  end

  def get_frame_pin_total
    ball_one + ball_two + (ball_three ? ball_three : 0)
  end

  def set_frame_score
    if frame_number == 1
      frame_score = get_frame_pin_total
    else
      frame_score += get_frame_pin_total
    end
  end

  def set_frame_number
    frame_number = self.game.frames.length
  end

  # def is_strike?
  #   if ball_one == 10
  #     true
  #   else
  #     false
  #   end
  # end
  #
  # def is_spare?
  #   if ball_one != 10 && (ball_one + ball_two + ball_three) == 10
  #     true
  #   else
  #     false
  #   end
  # end
end
