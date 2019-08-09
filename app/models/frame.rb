class Frame < ApplicationRecord
  belongs_to :game
  validates :ball_one, :ball_two, presence: true
  
  before_create do
    @game = self.game
    self.strike = true if ball_one == 10
    self.spare = true if ball_one != 10 && get_frame_pin_total == 10
    self.frame_number = @game.frames.length + 1
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
end
