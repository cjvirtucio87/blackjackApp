module ControllerHelpers

  def check_bet
    if bet = params['input']['bet']
      session['bet'] = bet
    end
    session['bet'] 
  end

end