require 'spec_helper'


describe 'api/v1/stories', type: :api do

	let(:story) { Story.create(title: "Test Story") }
	let(:response) { JSON.parse(last_response.body) }
	let(:user) { FactoryGirl.create(:user,
				email: "sam@example.com") }

	before :each do 
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


	context "#confirm_start" do 
		it "if the confirmation_token matches the player_account"
		it "responds with success page if correct token"
		it "sends first scene of story"

	end


end