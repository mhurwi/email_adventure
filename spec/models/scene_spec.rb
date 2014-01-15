require 'spec_helper'

describe Scene do 
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create }
	let(:scene2) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:choice) { scene.choices.create(target_scene_id: scene2.id.to_s) }

	before :each do 
		Choice.stub(:find).and_return(choice)
	end
	it "has text" do 
		scene.text = "It was a dark and stormy night"
		expect(scene.text).to eql "It was a dark and stormy night"
	end

	it "has many choices" do 

		expect(scene.choices.count).to eql 1
	end

	it "knows if it is the final scene" do 
		scene.choices.first.remove
		expect(scene.choices.count).to eql 0
		expect(scene.final?).to be_true
	end

	it "knows if it is the beginning" do 
		expect(scene.beginning?).to be_true
		expect(scene2.beginning?).to be_false
	end

	it "knows its preceding scene" do 
		expect(scene2.preceding_scene).to eql scene.id.to_s
	end
	
	it "gets its preceding scene" do 
		expect(scene2.preceding_scene.id).to eql scene.id
	end

	it "gets its preceding choice" do 
		expect(scene2.preceding_choice.id).to eql scene.choices.first.id.to_s
	end

	

end