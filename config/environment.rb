# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Jueso::Application.initialize!

#Active admin required

Jueso::Application.configure do
   config.active_support.deprecation = :log
   config.cache_classes = false
   
   # Config email
   config.action_mailer.default_url_options = { :host => 'www.jue.so' }
   config.action_mailer.raise_delivery_errors = true

   # set delivery method to :smtp, :sendmail or :test
   config.action_mailer.delivery_method = :smtp
   config.action_mailer.default :charset => "utf-8"

end

#email




