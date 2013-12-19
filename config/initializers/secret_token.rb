# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Emailer::Application.config.secret_key_base = '8b58debc3d5e7f5f18510f3b931ce71726808dcaca15f6f51f7d9f686078bd0f276c7fc229b83aeacd794cf5ae2f02ac9ca407f499a98a55ac1bf68b91d462a4'
