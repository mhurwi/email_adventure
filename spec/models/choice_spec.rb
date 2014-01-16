require 'spec_helper'

describe Choice do 
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(text: "I am in love with you.") }
	let(:target_scene) { story.scenes.create(text: "Hurray, I'm so happy!") }
	let(:choice) { scene.choices.create(target_scene_id: target_scene.id.to_s)}
	
	it "has text" do 
		choice.text = "Will you marry me?"
		expect(choice.text).to eql "Will you marry me?"
	end

	it "has a target scene" do 
		expect(choice.target_scene).to eql target_scene
	end

	it "knows if it leads to final scene" do 
		expect(choice.leads_to_final_scene?).to be_true
	end

end