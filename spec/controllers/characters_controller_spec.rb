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

	context '#create' do 
		before :each do 
			post :create, user_id: user.id.to_s, 
										character: {
											first_name: "Bob",
											last_name: "Bobward"
										}
		end
		it "creates a new character for a user" do 
			expect(user.characters.first.last_name).to eql "Bobward"
		end
	end

	context '#edit' do 
		before :each do 
			get :edit, user_id: user.id.to_s, id: character.id.to_s
		end

		it "assigns @character" do 
			expect(assigns(:character)).to eql character
		end
	end

	context '#update' do 
		before :each do 
			put :update, user_id: user.id.to_s, id: character.id.to_s,
										character: {
											first_name: "Sally"
										}
		end
		it "updates the first name" do 
			expect(character.reload.first_name).to eql "Sally"
		end
	end

	context '#destroy' do 
		before :each do 
			delete :destroy, user_id: user.id.to_s, id: character.id.to_s
		end
		it "removes character" do 
			expect {character.reload}.to raise_error Mongoid::Errors::DocumentNotFound
		end
	end
end