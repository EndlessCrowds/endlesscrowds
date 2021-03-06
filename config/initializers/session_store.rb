# Be sure to restart your server when you modify this file.

if Rails.env.production? && defined? Configuration
  if Configuration[:base_domain]
    Catarse::Application.config.session_store :cookie_store, key: '_catarse_session', domain: Configuration[:base_domain]
  else
    Catarse::Application.config.session_store :cookie_store, key: '_catarse_session'
  end
else
  # We should be running initial migrations to be here. The Configuration model does not yet exist to be read from.
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Catarse::Application.config.session_store :active_record_store

