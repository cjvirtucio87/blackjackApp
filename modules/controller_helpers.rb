module ControllerHelpers

  def get_bet
    if input = params['input']
      input['bet']
    else
      session['bet']
    end
  end

  def make_dealer
    Dealer.new(session['cards'],
               session['player_hand'],
               session['dealer_hand'])
  end

  def store_session(dealer,bet)
    session['cards'] = dealer.parse_deck
    session['player_hand'] = dealer.parse_player_hand
    session['dealer_hand'] = dealer.parse_dealer_hand
    session['bet'] = bet
  end

end