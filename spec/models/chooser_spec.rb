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

	it "exists" do 
		expect(chooser).to be_true
	end

	it "responds to 'parse email'" do 
		expect(chooser.respond_to?(:parse_email)).to be_true
	end

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