require 'pry'
require 'pry-nav'
require 'dotenv'
Dotenv.load

require "stripe"
Stripe.api_key = ENV["SECRET_KEY"]
# create receiving managed account
receiving_managed_account = Stripe::Account.create(
  :managed => true,
  :country => 'US',
  :email => 'bob@example.com'
)
# receiving_managed_account = Stripe::Account.retrieve(receiving_managed_account.id)
bank_account = { :object => "bank_account",
  :account_number => "000123456789",
  :country => "us",
  :currency => "usd",
  :routing_number => "110000000"
}
receiving_managed_account.external_accounts.create(:external_account => bank_account)
# create sending managed account
card = {
    :object => "card",
    :number => "4000000000000077",
    :exp_month => 11,
    :exp_year => 2016,
    :cvc => "314"
  }
sending_customer = Stripe::Customer.create(
  :description => "Customer for test@example.com",
  :source => card # obtained with Stripe.js
)
amount = 400
PINP_CUT = 0.01
charge = Stripe::Charge.create(
  :amount => amount,
  :currency => "usd",
  :customer => sending_customer.id,
  :description => "Charge for test@example.com",
  :destination => receiving_managed_account.id,
  :application_fee => ((amount.to_f * PINP_CUT) * 100).to_i
)
binding.pry