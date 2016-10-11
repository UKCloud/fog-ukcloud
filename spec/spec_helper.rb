$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'fog/ukcloud'

require 'vcr'

VCR.configure do |c|
  #c.hook_into                :webmock
  c.hook_into                :excon
  c.cassette_library_dir     = 'cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
end
