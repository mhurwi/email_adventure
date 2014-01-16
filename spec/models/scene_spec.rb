require 'spec_helper'

describe Scene do 
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create }
	let(:scene2) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:scene3) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:choice) { scene.choices.create(target_scene_id: scene2.id.to_s) }
	let(:choice2) { scene.choices.create(target_scene_id: scene3.id.to_s) }
	
	before :each do 
		choice
		choice2
		# Choice.stub(:find).and_return(choice)
	end
	
	it "has body" do 
		scene.body = "It was a dark and stormy night"
		expect(scene.body).to eql "It was a dark and stormy night"
	end

	it "has many choices" do 
		expect(scene.choices.count).to eql 2
	end

	it "knows if it is the final scene" do 
		scene.choices.first.remove
		scene.choices.last.remove
		expect(scene.choices.count).to eql 0
		expect(scene.final?).to be_true
	end

	it "knows if it is the beginning" do 
		expect(scene.beginning?).to be_true
		expect(scene2.beginning?).to be_false
	end

	it "gets its preceding scene" do 
		expect(scene2.preceding_scene).to eql scene
	end

	it "gets next possible scenes" do 
		expect(scene.next_possible_scenes.count).to eql 2
	end



	

end