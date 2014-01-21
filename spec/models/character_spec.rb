require 'spec_helper'

describe Character do 
	let(:user) { FactoryGirl.create(:user)}
	let(:character) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter",
		) }
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(
				character_id: character.id.to_s
		) }
	let(:scene2) { story.scenes.create(
				preceding_scene_id: scene.id.to_s,
				character_id: character.id.to_s
		) }
	
	it "has a first name" do 
		expect(character.first_name).to eq "Frank"
	end

	it "has a last name" do 
		expect(character.last_name).to eq "Frankfurter"
	end

	it "belongs to a user" do 
		expect(character.user).to eql user
	end

	it "has an email account" do 
		character.create_email_account
		expect(character.email_account).to be_present
	end

	it "gets a collection of all the scenes its in" do 
		scene
		scene2
		expect(character.scenes.count).to eql 2
		expect(character.scenes.first).to eql scene
	end

end