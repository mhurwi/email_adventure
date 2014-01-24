require 'spec_helper'

describe 'Characters' do 
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

	context 'INDEX /users/:user_id/characters' do 
		before :each do 
			character
			character2
			email_account
			visit user_characters_path(user)
		end

		it "gets 200 status code" do 
			expect(status_code).to eql 200
		end

		it "shows character names" do 
			expect(page).to have_content "Bob Bobward"
		end

		it "shows email account address" do 
			expect(page).to have_content "bob@example.com"
		end

		it "has a button for each character" do 
			expect(page).to have_content "View Character"
		end
	end
end