if Rails.env == "production"
  require 'exception_notifier'
  Rankey::Application.config.middleware.use ExceptionNotifier,
      :email_prefix => "[rankey.it] ",
      :sender_address => %{"rankey.it" <m4kevoid@gmail.com>},
      :exception_recipients => %w{makevoid@gmail.com}#,
      # ignore_exceptions: [ActionView::MissingTemplate]
end