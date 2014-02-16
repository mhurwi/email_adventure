require "spec_helper"

describe StoryMailer do
	let(:user) { FactoryGirl.create(:user)}
	let(:story) { FactoryGirl.create(:story) }
	let(:player_account) { OpenStruct.new(
		email: "player@example.com"
		)} 	
 	let(:confirm_start_email) { StoryMailer.confirm_start(
 				story, player_account
 				)}

 	before :each do 
 		email_account
 		choice
 		choice2
 		confirm_start_email.deliver
 	end

	context "confirm_start" do 
		it "emails player the confirm_start email"
		it "uses the app deafault SMPT settings"
		it "includes link to confirm_start"
		it "includes confirmation_token as param in link"
		it "includes player_account_id in link"
		it "includes story_id in link"
 	end
end
