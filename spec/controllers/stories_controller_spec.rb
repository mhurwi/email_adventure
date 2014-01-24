require 'spec_helper'

describe StoriesController do 

	let(:user) { FactoryGirl.create(:user)}
	let(:story) { user.stories.create(title: "Test Story") }


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
end