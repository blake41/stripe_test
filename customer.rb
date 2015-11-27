require 'pry'
require 'pry-nav'
require 'dotenv'
Dotenv.load

require "stripe"
Stripe.api_key = ENV["SECRET_KEY"]
card = {
    :object => "card",
    :number => "4000000000000077",
    :exp_month => 11,
    :exp_year => 2016,
    :cvc => "314"
  }
customer = Stripe::Customer.create(
  :description => "Customer for test@example.com",
  :source => card # obtained with Stripe.js
)
charge = Stripe::Charge.create(
  :amount => 400,
  :currency => "usd",
  :customer => customer.id,
  :description => "Charge for test@example.com"
)
