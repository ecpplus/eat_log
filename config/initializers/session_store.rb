# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitter_eat2_session',
  :secret      => 'b0b5c4cf9184ddb41d57074a85915527713c01eec3bca88b18f91716e82307da8a2ac1464c5c822304b53b256fe843943a95ac2425ee1a44139adccce5839211'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
