path = File.expand_path "../", __FILE__

require "#{path}/domain_api"

PASS = ""

# info - http://www.domainapi.com/documentation/how-to-use-domainapi/servuces-provided/domain-appraisal-api.html
# domain_appraisal -> http://www.domainapi.com/documentation/how-to-use-domainapi/servuces-provided/domain-info-api.html

data = DomainAPI::use('makevoid',PASS)::get('domain_appraisal')::on('makevoid.com')

puts data



