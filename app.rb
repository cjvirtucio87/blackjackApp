#!usr/bin/env ruby -w
require 'sinatra'
require 'erb'
require './classes/dealer_class'
require './classes/card_class'
require './modules/view_helpers'
require './modules/controller_helpers'
require 'sinatra/form_helpers'

enable :sessions

include GameClasses
helpers ViewHelpers
helpers ControllerHelpers

get '/' do
  redirect to('/blackjack')
end

get '/blackjack' do
  bet = get_bet
  dealer = make_dealer
  store_session(dealer,bet)
  erb :blackjack, locals: { player_hand: dealer.parse_player_hand,
                            dealer_hand: dealer.parse_dealer_hand,
                            gameover: false,
                            outcome: nil,
                            bet: bet }
end

post '/blackjack/hit' do
  bet = get_bet
  dealer = make_dealer
  dealer.hit
  store_session(dealer,bet)
  next_route = dealer.bust? ? '/blackjack/stay' : back
  redirect(next_route)
end

get '/blackjack/stay' do
  bet = get_bet
  dealer = make_dealer
  outcome = dealer.stay
  erb :blackjack, locals: { player_hand: dealer.parse_player_hand,
                            dealer_hand: dealer.parse_dealer_hand,
                            gameover: true,
                            outcome: outcome, 
                            bet: bet }
end