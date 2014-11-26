Csa::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # addresses the following warning when running `rake test:units`
  # 
  # [deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
  # 
  # Must also be set to false for the feature/locales.feature to pass
  I18n.enforce_available_locales = false
  config.i18n.fallbacks = true
  
  # These settings work for staff over exchange outside
  # of network
  #config.action_mailer.smtp_settings = {
  #address: "smtphost.aber.ac.uk",
  #port: 587,
  #user_name: 'cwl',
  #password: '******', # Put password here, although rather dangerous
  #authentication: :login,
  #enable_starttls_auto: true
  #}

  # This should work within the network
  config.action_mailer.smtp_settings = {
      address: "smtphost.aber.ac.uk",
      port: 25
  }

  ADMIN_EMAIL="admin@host.ac.com" # Change to your email

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  Paperclip.options[:command_path] = '/usr/local/bin/'

  #config.use_ssl = true
  config.use_ssl = false
  config.ssl_port = 3001
  NON_SSL_PORT = 3000
end
