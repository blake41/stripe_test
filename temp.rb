require 'pry'
require 'pry-nav'
require 'dotenv'
Dotenv.load

require "stripe"
Stripe.api_key = ENV["SECRET_KEY"]
# create receiving managed account
sending_managed_account = Stripe::Account.create(
  :managed => true,
  :country => 'US',
  :email => 'bob@example.com'
)
card_number = "4242424242424242"
card = Stripe::Token.create(
  :card => {
    :number => card_number,
    :exp_month => 11,
    :exp_year => 2016,
    :cvc => "314",
    :currency => "usd"
  },
)
binding.pry
sending_managed_account.external_accounts.create({:external_account => card.id})