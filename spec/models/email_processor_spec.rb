require 'spec_helper'
require_relative '../../lib/email_processor'


describe "EmailProcessor" do 
	let(:email) { FactoryGirl.create(:email)}
	it "responds to process" do 
		expect(EmailProcessor).to respond_to :process
	end
end