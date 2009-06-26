# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scconnect_session',
  :secret      => 'c9a5a73c3295e43db7c653d9d2b7d4d3ea23323ec9f7936ec0a71b739c3d91666408df394569e93e9d041ab49b36846ca81295d77641fe6156f8b85765d70817'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
