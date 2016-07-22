#!usr/bin/env ruby -w

require 'sinatra'
require 'erb'
require './modules/helpers'
require 'sinatra/form_helpers'

enable :sessions

include GameClasses

get '/' do
  "Hello, world"
end

get '/blackjack' do
  dealer = session['dealer'] || Dealer.new
  dealer.deal unless dealer.dealt
  session['dealer'] = dealer
  erb :blackjack, locals: { player_hand: dealer.player_hand,
                            dealer_hand: dealer.dealer_hand,
                            gameover: false }
end

post '/blackjack/hit' do
  dealer = session['dealer']
  dealer.hit
  next_route = dealer.bust? ? '/blackjack/stay' : back
  redirect(next_route)
end

get '/blackjack/stay' do
  dealer = session['dealer']
  dealer.stay
  erb :blackjack, locals: { player_hand: dealer.player_hand,
                            dealer_hand: dealer.dealer_hand,
                            gameover: true }
end