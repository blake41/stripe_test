require 'pry'
require 'pry-nav'
require 'dotenv'
Dotenv.load

require "stripe"
Stripe.api_key = ENV["SECRET_KEY"]
card = {
    :number => "4000000000000077",
    :exp_month => 11,
    :exp_year => 2016,
    :cvc => "314"
  }
charge = Stripe::Charge.create(
  :amount => 400,
  :currency => "usd",
  :source => card,
  :description => "Charge for test@example.com"
)
binding.pry