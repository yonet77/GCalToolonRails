# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_GCalToolonRails_session',
  :secret      => 'b663e561a51775f9d744a08b1991314dd8293dc980667b37d5034e314a8adcca65aeb7b2d5b5cc4347821e4388b830659243adece885c22d80a75cbbb43533cb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
