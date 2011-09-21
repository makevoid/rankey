require 'adwords4r'

# PD: chiamare google



# http://code.google.com/apis/adwords/

adwords = AdWords::API.new(AdWords::AdWordsCredentials.new({
  'developerToken' => 'DEVELOPER_TOKEN',
  'applicationToken' => 'APPLICATION_TOKEN',
  'useragent' => 'Ruby Sample',
  'password' => 'PASSWORD',
  'email' => 'user@domain.com'
  'clientEmail' => 'user2@domain.com',
  'environment' => 'PRODUCTION',
}))

# getKeywordVariations