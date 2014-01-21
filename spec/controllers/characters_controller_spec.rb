require 'spec_helper'

describe CharactersController do 
	let(:user) { FactoryGirl.create(:user) }
	let(:character) { user.characters.create(first_name: "Bob")}

	context '#index' do 
		before :each do 
			get :index, user_id: user.id.to_s
		end

		it "exists" do 
			expect(response.status).to eql 200
		end
		it "gets list of users characters" do 
			character
			expect(assigns(:characters).first.first_name).to eql "Bob"
		end
	end

end