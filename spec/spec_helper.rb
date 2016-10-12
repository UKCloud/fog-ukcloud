$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'fog/ukcloud'
require 'vcr'

VCR.configure do |c|
  c.hook_into                :excon
  c.cassette_library_dir     = 'spec/cassettes'
  c.configure_rspec_metadata!


  c.ignore_request do |request|
    request.uri =~ %r{.*/authenticate$}
  end

  #When interacting with the real API, prevent recording of credentials or cookies to VCR cassettes & overwrite all existing cassettes
  if ENV['VCR_RECORDING'] then
    c.default_cassette_options = { :record => :all }
    c.before_record do |i|
      dummy_cookie = "rack.session=DUMMYBAh7B0kiD3Nlc3Npb25faWsdfhrZFVEkiRTM0YjAzYmVkZGJlNjc3NTYwODky%0AY2U4YzllNWUzYjM3ZjJjYjI5ZWFkMzBsdffdfsWMwOTg2MTc5YWI1NTRmNWEG%0AOwBGSSIMdXNlfdsZAY7AEZpAvkB%0A--691ce0965f6e0e5ad9fsddca271f2ba5e43fsd57e; path=/api; expires=Wed, 12-Oct-2016 10:51:49 GMT; HttpOnly; secure, _session_id=34b03beddbe6775fsd2ce8c9e5e3b37f2cbfds0a4fdec0986asdaf5a; path=/api; expires=Wed, 12-Oct-2016 10:51:49 GMT; HttpOnly; secure"
      i.response.headers['Set-Cookie'][0] = dummy_cookie
    end

    c.filter_sensitive_data("somepassword") { ENV['UKCLOUD_PASSWORD'] }
    c.filter_sensitive_data("someemail@somedomain") { ENV['UKCLOUD_USERNAME'] }

  else
    c.default_cassette_options = { :record => :new_episodes }
  end
end

RSpec.configure do |c|

end
