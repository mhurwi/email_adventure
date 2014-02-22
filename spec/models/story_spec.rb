require 'spec_helper'

describe Story do 
	let(:story) { Story.create }
	let(:user) { FactoryGirl.create(:user)}
	let(:scene) { story.scenes.create(character_id: character.id.to_s) }
	let(:scene2) { story.scenes.create(character_id: character2.id.to_s) }
	let(:character) { user.characters.create() }
	let(:character2) { user.characters.create() }

	before :each do 
		user
		story
		scene
		scene2
		character
		character2
	end


	it "has a name" do 
		story.title = "Test Story"
		expect(story.title).to eql "Test Story"
	end

	it "has many scenes" do 
		story.save
		expect(story.scenes.first).to eql scene
	end

	context "user" do 
		it "has a user" do 
			story.user = user.id.to_s
			expect(story.user.email).to eq "example@example.com"		
		end
	end

	it "gets list of characters in the story" do 
		expect(story.characters.count).to eql 2
	end

	it "gets the default character for story" do 
		story.update_attributes(default_character_id: character.id.to_s)
		expect(story.default_character).to eql character
	end
end