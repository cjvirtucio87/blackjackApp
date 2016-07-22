module ControllerHelpers

  def check_bet
    if bet = params['bet']
      session['bet'] = bet
    end
    session['bet'] 
  end


end