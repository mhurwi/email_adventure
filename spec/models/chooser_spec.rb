require 'spec_helper'

describe Chooser do 

	let(:email) { FactoryGirl.create(:email,
		body: "green\nstory_id:#{story.id.to_s}/story_id\nscene_id:#{scene.id.to_s}/scene_id") }
	let(:chooser) { Chooser.new(email: email) }
	let(:story) { Story.create() }
	let(:scene) { story.scenes.create() }
	let(:next_scene) { story.scenes.create(character_id: character.id.to_s) }
	let(:character) { Character.create()}
	let(:choice) { scene.choices.create(
		text: "green", 
		target_scene_id: next_scene.id.to_s )}
	let(:player) { FactoryGirl.create(:user, 
		email: "user@email.com" )}

	before :each do 
		player
		story
		scene
		next_scene
		character
		choice
	end

	context "#send_email" do 
		before :each do 
			chooser.parse_email
			chooser.choose_next_scene
		end
		it "sends an email" do 
			expect(SceneMailer).to receive(:scene_email).with(story, next_scene, player).and_return(double("SceneMailer", deliver: true))
			chooser.send_email
		end
	end


	context "#choose_next_scene" do 
		before :each do 
			chooser.parse_email
			chooser.choose_next_scene
		end
			it "sets the choice" do
				expect(chooser.choice).to eql choice
			end
			it "picks the next scene" do 
				expect(chooser.next_scene).to eql next_scene
			end
	end

	context "#parse_email" do 
		before :each do 
			chooser.parse_email
		end
		it "sets story" do 
			expect(chooser.story).to eql story
		end
		it "sets scene" do 
			expect(chooser.scene).to eql scene
		end
		it "sets choice_text" do 
			expect(chooser.choice_text).to eql "green"
		end
		it "sets player" do 
			expect(chooser.player).to eql player
		end
	end

	

	############################################
	# Private methods, do we need to test these?
	it "extract_story_id" do 
		expect(chooser.extract_story_id).to eql story.id.to_s
	end 
	it "extract_scene_id" do 
		expect(chooser.extract_scene_id).to eql scene.id.to_s
	end 
	it "extracts the players choice" do 
		expect(chooser.extract_choice).to eql "green"
	end



end