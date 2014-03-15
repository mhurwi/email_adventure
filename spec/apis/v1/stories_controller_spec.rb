require 'spec_helper'


describe 'api/v1/stories', type: :api do

	let(:story) { Story.create(
		title: "Test Story",
		default_character_id: character.id.to_s )}
	let(:scene) { story.scenes.create(
				character_id: character.id.to_s ) } 
	let(:character) { Character.create(
				first_name: "Chad",
				last_name: "Character" )}
	let(:character_email_account) { character.create_email_account(
				password: "testtest",
				address: "character@example.com",
				smtp_host: "123.host"
				)}
	let(:response) { JSON.parse(last_response.body) }
	let(:user) { FactoryGirl.create(:user,
				email: "sam@example.com") }
	let(:player_account) { PlayerAccount.create(
				email: "sam@example.com",
				confirmation_token: "12345")}

	let(:confirm_start_params) { {
			  story_id: story.id.to_s,
				player_account_id: player_account.id.to_s,
				confirmation_token: player_account.confirmation_token } }

	before :each do 
		story
		scene
		character
		character_email_account
		ActionMailer::Base.deliveries = []
	end

	context "#start_story" do 
		it "sends status 200 after receiving email with story ID" do 
			post "api/v1/stories/start_story", email: "bob@example.com", story_id: story.id.to_s
			expect(last_response.status).to eql 200
		end

		it "response includes email" do 
			post "api/v1/stories/start_story", email: "bob@example.com", story_id: story.id.to_s
			expect(response["message"]).to include "bob@example.com"
		end

		it "response includes story_title" do 
			post "api/v1/stories/start_story", email: "bob@example.com", story_id: story.id.to_s
			expect(response["story"]).to include "Test Story"
		end

		it "sends confirmation email" do 
			post "api/v1/stories/start_story", email: "bob@example.com", story_id: story.id.to_s
			expect(ActionMailer::Base.deliveries.count).to eql 1
		end
	end


	


end