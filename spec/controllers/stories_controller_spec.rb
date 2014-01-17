require 'spec_helper'

describe StoriesController do 

	let(:story) { FactoryGirl.create(:story) }

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
end