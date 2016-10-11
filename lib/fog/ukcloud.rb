require 'fog/core'
require 'fog/ukcloud/errors'

module Fog
  module UKCloud
    extend Fog::Provider
    service(:compute, 'Compute')
  end

  module Compute
    autoload :UKCloud, File.expand_path('../ukcloud/compute', __FILE__)
  end

end
