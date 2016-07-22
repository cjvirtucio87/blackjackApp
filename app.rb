#!usr/bin/env ruby -w
require 'pry'
require 'sinatra'
require 'erb'
require './modules/dealer_helpers'
require './modules/card_helpers'
require './modules/view_helpers'
require './modules/controller_helpers'
require 'sinatra/form_helpers'

enable :sessions

include GameClasses
include ViewHelpers
include ControllerHelpers

get '/' do
  'Hello, world'
end

get '/blackjack' do
  bet = session['bet']
  dealer = session['dealer'] || Dealer.new
  dealer.deal unless dealer.dealt
  session['dealer'] = dealer
  erb :blackjack, locals: { player_hand: dealer.player_hand,
                            dealer_hand: dealer.dealer_hand,
                            gameover: false,
                            outcome: nil,
                            bet: bet }
end

post '/blackjack/hit' do
  bet = check_bet
  dealer = session['dealer']
  dealer.hit
  dealer.store(bet)
  next_route = dealer.bust? ? '/blackjack/stay' : back
  redirect(next_route)
end

get '/blackjack/stay' do
  bet = session['bet']
  dealer = session['dealer']
  outcome = dealer.stay
  erb :blackjack, locals: { player_hand: dealer.player_hand,
                            dealer_hand: dealer.dealer_hand,
                            gameover: true,
                            outcome: outcome, 
                            bet: bet }
end