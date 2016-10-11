require 'spec_helper'

describe Fog::Compute::UKCloud do

  it "returns an error on failed login" do
    VCR.insert_cassette("login_fail")


    params = {:ukcloud_username => 'dummy', :ukcloud_password => 'dummy'}

    svc = Fog::Compute::UKCloud.new(params)
    expect{svc.login}.to raise_error Fog::UKCloud::Errors::Unauthorised


  end

end
