Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.action_mailer.raise_delivery_errors = true

# set delivery method to :smtp, :sendmail or :test
config.action_mailer.delivery_method = :smtp

# these options are only needed if you choose smtp delivery
config.action_mailer.smtp_settings = {
  :address        => 'smtp.yandex.ru',
  :port           => 25,
  :domain         => 'www.yandex.ru',
    :authentication       => "login",
    :enable_starttls_auto => true,
  :user_name      => 'sergelus',
  :password       => 'Fast@2016'
}

smtp = { :address => 'smtp.yandex.ru',  :port => 25, :domain => 'www.yandex.ru',  :user_name => 'sergelus', :password => 'Fast@2016', :enable_starttls_auto => 'true' , :authentication =>:login}
#smtp = { :address => 'smtp.gmail.com',  :port => 587, :domain => 'gmail.com',  :user_name => 'jdanovalarisa7@gmail.com', :password => ',thnfrepb[f', :enable_starttls_auto => 'true', :authentication=>:plain}
Mail.defaults { delivery_method :smtp, smtp }

config.action_mailer.perform_deliveries = true

 #config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
#config.assets.precompile += %w( vendor/modernizr.js )
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  #config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  
  Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[PREFIX] ",
    :sender_address => %{"sergelus" <sergelus@yandex.ru>},
    :exception_recipients => %w{sergelus84@gmail.com}
  }
  
end


