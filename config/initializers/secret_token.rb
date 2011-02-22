# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
unless Rails.env.production?
  ENV['SECRET_TOKEN'] ||= '4174e22bd547dbfe293e8b5b99f6525656f7c76fcd4cd20edd19171583dc3d1b9068703b34e7e280b3fee9f93f27ed594b80283d4a6e2c94cbcde2f71e6b90ac'
end
SemyonPerepelitsa::Application.config.secret_token = ENV['SECRET_TOKEN']
