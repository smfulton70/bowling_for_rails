module FramesHelper
  def convert_to_boolean(string)
    if string == "true"
      true
    elsif string == "false"
      false
    end
  end
end
