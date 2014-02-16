require 'spec_helper'

describe PlayerAccount do 
	let(:story) { Story.create(title: 'Test Story')}
	let(:user) { FactoryGirl.create(:user, email: "existing@example.com")}
	let(:old_player_account) { user.create_player_account(email: user.email)}
	let(:new_player_account) { PlayerAccount.find_or_create_by_email "new@example.com" }

	it "finds existing by email" do 
		user
		found_player_account = PlayerAccount.find_or_create_by_email user.email
		expect(found_player_account).to eql user.player_account
	end
	describe "new" do 
		it "creates new by email" do 
			expect(new_player_account.user).to eql nil
			expect(new_player_account.reload.email).to eql "new@example.com"
		end
		it "associates self with user" do 
			user
			new_player_account.associate_with_user(user.id.to_s)
			expect(new_player_account.user).to eql user
		end
		it "generates a confirmation_token" do 
			expect(new_player_account.confirmation_token).to be_present
		end
	end
	it "adds story" do 
		story
		new_player_account.add_story(story.id.to_s)
		expect(new_player_account.stories.first).to eql story
	end
	it "removes story"
	it "has list of stories"
	it "has a story tracker" do 
		pending "need a model to track players progress in a story"
	end

end