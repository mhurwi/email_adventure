require 'spec_helper'

describe EmailAccount do 
	let(:user) { FactoryGirl.create(:user)}
	let(:character) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter",
		)}
	let(:email_account) { character.create_email_account(
				address: "frank@example.com"
		)}

	it "has an address" do 
		expect(email_account.address).to eql "frank@example.com"
	end

end