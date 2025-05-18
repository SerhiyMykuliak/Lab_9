Sentry.init do |config|
  config.dsn = 'https://112aab2e1ceeb93e3586668bc35ffe14@o4509344173129728.ingest.de.sentry.io/4509344174506064'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.environment = Rails.env
  
  config.send_default_pii = true
end