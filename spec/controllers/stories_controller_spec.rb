require 'spec_helper'

describe StoriesController do 

	let(:user) { FactoryGirl.create(:user)}
	let(:story) { user.stories.create(title: "Test Story") }
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
	let(:player_account) { PlayerAccount.create(
				email: "sam@example.com",
				confirmation_token: "12345")}

	let(:confirm_start_params) { {
			  story_id: story.id.to_s,
				player_account_id: player_account.id.to_s,
				confirmation_token: player_account.confirmation_token } }

	before :each do 
		sign_in user
	end
	context "#index" do 
		it "gets a 200 status code" do 
			get :index
			expect(response.status).to be 200
		end

		it "gets list of stories" do 
			story
			get :index
			expect(assigns(:stories).first).to eql story
		end
	end

	context "#create" do
		it "creates itself for the current_user" do
			story
			post :create, story: { title: "test story 2" } 
			expect(Story.all.count).to eq 2			
		end
	end

	context "#confirmation_success" do 
		before :each do 
			player_account
			story
			scene
			character
			character_email_account
			ActionMailer::Base.deliveries = []
		end
		it "sends first scene if the confirmation_token matches the player_account" do 
			get :confirmation_success, story_id: story.id.to_s,
																							player_account_id: player_account.id.to_s,
																							confirmation_token: player_account.confirmation_token 
																						
			expect(ActionMailer::Base.deliveries.count).to eql 1
		end
		it "does not send first scene when incorrect confirmation token" do 
			get :confirmation_success, story_id: story.id.to_s,
																							player_account_id: player_account.id.to_s,
																							confirmation_token: "apples" 
																						
			expect(ActionMailer::Base.deliveries.count).to eql 0
		end
		it "responds with success page if correct token" do 
			get :confirmation_success, story_id: story.id.to_s,
																							player_account_id: player_account.id.to_s,
																							confirmation_token: player_account.confirmation_token 
																						
			expect(response.status).to eql 200
		end

	end
end