module ViewHelpers

  def main_header(outcome,bet)
    outcome.nil? ? "Welcome to Blackjack" : display_outcome(outcome,bet)
  end

  def display_outcome(outcome,bet)
    if outcome
      "Player wins. $#{bet*2}"
    else
      "Player loses."
    end
  end

end