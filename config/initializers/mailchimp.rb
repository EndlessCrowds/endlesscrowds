# Comment this out when running rake db:migrate for the first time
if defined? Configuration
  MAILCHIMP_API_KEY = Configuration[:mailchimp_api_key]
else
  # We should be running initial migrations to be here. The Configuration model does not yet exist to be read from.
end