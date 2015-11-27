require 'pry'
require 'pry-nav'
require 'dotenv'
Dotenv.load

require "stripe"
Stripe.api_key = ENV["SECRET_KEY"]
card_number = "4000000000000077"
card = Stripe::Token.create(
  :card => {
    :number => card_number,
    :exp_month => 11,
    :exp_year => 2016,
    :cvc => "314"
  },
)

charge = Stripe::Charge.create(
  :amount => 400,
  :currency => "usd",
  :source => card.id, # obtained with Stripe.js
  :description => "Charge for test@example.com"
)
binding.pry