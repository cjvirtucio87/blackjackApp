module ViewHelpers

  def main_header(outcome,bet)
    content = nil
    if outcome.nil? 
      content ="Welcome to Blackjack"
    else 
      content = display_outcome(outcome,bet)
    end
    tag :h1, content
  end

  def display_outcome(outcome,bet)
    if outcome
      "Player wins. $#{bet.to_i*2}"
    else
      "Player loses."
    end
  end

  def show_dealer_hand(hand,gameover)
    tag :h1, "Dealer's Hand"
    if gameover
      tag :p, "#{hand}"
    else
      tag :p, "#{hand[0]}"
    end
  end


end