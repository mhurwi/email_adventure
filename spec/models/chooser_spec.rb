require 'spec_helper'

describe Chooser do 

	let(:email) { FactoryGirl.create(:email,
		body: "green\nstory_id:#{story.id.to_s}/story_id\nscene_id:#{scene.id.to_s}/scene_id") }
	let(:chooser) { Chooser.new(email) }
	let(:story) { Story.create() }
	let(:scene) { story.scenes.create() }

	before :each do 
		story
		scene
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
		it "sets player_email" do 
			expect(chooser.player_email).to eql "user@email.com"
		end
	end


	#################
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