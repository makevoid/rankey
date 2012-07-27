MAIL_DEFAULT_FROM = "m4kevoid@gmail.com"
pass_file = File.expand_path("~/.password")


ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name:  MAIL_DEFAULT_FROM,
  password:   File.exist?(pass_file) ? File.read(File.expand_path("~/.password")).strip.gsub(/33/, '') : "",
  address:    "smtp.gmail.com",
  enable_starttls_auto: true,
  authentication:       :plain,
  port:       587
}
