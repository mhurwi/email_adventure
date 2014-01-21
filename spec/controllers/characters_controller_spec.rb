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


	context '#show' do 
		before :each do 
			get :show, user_id: user.id.to_s, id: character.id.to_s
		end

		it "assigns @character" do 
			expect(assigns(:character)).to eql character
		end
	end

	context '#new' do 
		before :each do 
			get :new, user_id: user.id.to_s
		end

		it "gets new character" do 
			expect(assigns(:character)).to be_present
		end
	end	
end