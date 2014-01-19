require 'spec_helper'

describe ChoicesController do 

	context '#create_target_scene' do 
		let(:story) { FactoryGirl.create(:story)}
		let(:scene) { story.scenes.create }
		let(:choice) { scene.choices.create }

		before :each do 
			post :create_target_scene, 
						story_id: story.id.to_s,
						scene_id: scene.id.to_s,
						choice_id: choice.id
		end

		it "creates a new scene" do 
			expect(story.scenes.count).to be 2
		end

		it "sets the choice.target_scene_id" do 
			expect(choice.reload.target_scene_id).to be_present
		end

		it "sets the preceding scene id on the new target scene" do 
			target_scene = Scene.find(choice.reload.target_scene_id)
			expect(target_scene.preceding_scene).to eql scene
		end	
	end

end