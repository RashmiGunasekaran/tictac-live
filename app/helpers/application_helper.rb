module ApplicationHelper
  def checked_pos(player1_position,player2_position,value)
    if !player1_position.nil? && !player2_position.nil?
      if player1_position.flatten().map(&:to_i).include?(value) || player2_position.include?(value)
        return true
      else
        return false
      end
  else
    return false
  end
  end


  def checked_player1(player,value)
    if !player.nil?
    if player.flatten().map(&:to_i).include?(value)
      return true
    else
      return false
    end
  else
    return false
  end
  end

  def checked_player2(player,value)
    if !player.nil?
      if player.include?(value)
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
