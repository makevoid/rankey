MAIL_DEFAULT_FROM = "m4kevoid@gmail.com"

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name:  MAIL_DEFAULT_FROM,
  password:   File.read(File.expand_path("~/.password")).strip.gsub(/33/, ''),
  address:    "smtp.gmail.com",
  enable_starttls_auto: true,
  authentication:       :plain,
  port:       587
}
