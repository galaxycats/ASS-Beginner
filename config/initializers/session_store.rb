# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_statr_session',
  :secret => '84af0f942012f1031e82d230256e155929e0106d06d13e233a4b8435925ab8d85431c79d1b4201b85f92201836f24e13f90153b2cb5defa2f8e4c759a17e15f4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
