require "spec_helper"

describe StoryMailer do
	let(:user) { FactoryGirl.create(:user)}
	let(:story) { FactoryGirl.create(:story) }
	let(:player_account) { PlayerAccount.new(
		email: "player@example.com",
		confirmation_token: 12345
		)} 	
 	let(:confirm_start_email) { StoryMailer.confirm_start(
 				story, player_account
 				)}
 	let(:sent_email) { ActionMailer::Base.deliveries.first }

 	before :each do 
 		ActionMailer::Base.deliveries = []
 		player_account
 		story
 		confirm_start_email.deliver
 	end

	context "confirm_start" do 
		it "emails player the confirm_start email" do 
			expect(ActionMailer::Base.deliveries.count).to eql 1
		end
		it "uses the app deafault SMPT settings"
		it "includes link to confirm_start" do 
			expect(sent_email.body).to match story_confirmation_success_url(story.id.to_s)
		end
		it "includes confirmation_token" do 
			expect(sent_email.body).to match "12345"
		end
		it "includes player_account_id" do 
			expect(sent_email.body).to match player_account.id.to_s
		end
		it "includes story_id" do 
			expect(sent_email.body).to match story.id.to_s
		end
		context "SMTP settings" do 
			it "uses correct default SMTP settings"
			it "uses the correct from addess"
		end
 	end
end
