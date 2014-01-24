require 'spec_helper'

describe EmailAccountsController do
	let(:user) { FactoryGirl.create(:user) }
	let(:character) { user.characters.create(
				first_name: "Bob", 
				last_name: "Bobward"
			)}
	let(:character2) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter"
			)}
	let(:email_account) { character.create_email_account(
				address: "bob@example.com"
		)}
	let(:story) { FactoryGirl.create(:story) }

	context '#show' do 
		before :each do 
			get :show, 
				user_id: user.id.to_s,
				character_id: character.id.to_s,
				id: email_account.id.to_s
		end
		it "shows the email_account" do 
			expect(response.status).to eq 200
		end
	end

	context '#new' do 
		before :each do 
			get :new, 
				user_id: user.id.to_s,
				character_id: character.id.to_s
		end
		it "shows the new email_account page" do 
			expect(response.status).to eq 200
		end
	end

	context '#edit' do 
		before :each do 
			get :edit, 
				user_id: user.id.to_s,
				character_id: character.id.to_s,
				id: email_account.id.to_s
		end
		it "shows the new email_account page" do 
			expect(response.status).to eq 200
		end
	end

end
