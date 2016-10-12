require 'spec_helper'

describe Fog::Compute::UKCloud do
  before(:all) do
    @user = ENV['UKCLOUD_USERNAME'] || 'someuser@somedomain'
    @pass = ENV['UKCLOUD_PASSWORD'] || 'somepassword'
  end

  before(:each) do
    params = {:ukcloud_username => @user, :ukcloud_password => @pass}
    @svc = Fog::Compute::UKCloud.new(params)
  end

  it "returns an error on failed login", :vcr do
    VCR.insert_cassette("login_fail")


    params = {:ukcloud_username => 'dummy', :ukcloud_password => 'dummy'}

    svc = Fog::Compute::UKCloud.new(params)
    expect{svc.login}.to raise_error Fog::UKCloud::Errors::Unauthorised


  end


  it "should have an empty cookie before login" do
    expect(@svc.cookies.empty?).to be true
  end


  it "returns a cookie on login", :vcr do
    VCR.insert_cassette("login_success")
    @svc.login

    expect(@svc.cookies.empty?).to be false
  end

  it "logs in automatically when no cookie", :vcr do
    VCR.insert_cassette("get_ping")


    @svc.get_ping
  end

end
