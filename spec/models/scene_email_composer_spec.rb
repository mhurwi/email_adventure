require 'spec_helper'

describe SceneEmailComposer do 
	let(:user) { FactoryGirl.create(:user)}
	let(:character) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter",
		)}
	let(:email_account) { character.create_email_account(
				address: "frank@example.com"
		)}
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(
		character_id: character.id.to_s) }
	let(:scene2) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:scene3) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:choice) { scene.choices.create(target_scene_id: scene2.id.to_s) }
	let(:choice2) { scene.choices.create(target_scene_id: scene3.id.to_s) }
	let(:recipient) { OpenStruct.new(email: "player@example.com")}
	let(:scene_email_composer) { SceneEmailComposer.new(
				story: story,
				scene: scene,
				character: scene.character,
				recipient: recipient
			)}

	it "gets story" do
		expect(scene_email_composer.story).to eq story
	end
	it "gets scene" do
		expect(scene_email_composer.scene).to eq scene
	end
	it "gets character" do
		expect(scene_email_composer.character).to eq character
	end
	it "gets recipient" do 
		expect(scene_email_composer.recipient.email).to eq "player@example.com"
	end

	context "sending a scene" do 
		before :each do 
			SceneMailer = double("SceneMailer", deliver: true)
		end
		it "calls SceneMailer to send intro scene" do 
			SceneMailer.should_receive(:intro_scene).with(
				story, scene, character, recipient
				).and_return(SceneMailer)
			scene_email_composer.send_intro_scene
		end
		it "calls SceneMailer to send the next scene" do 
			# SceneMailer.should_receive(:next_scene)
			SceneMailer.should_receive(:next_scene).with(
				story, scene, character, recipient
				).and_return(SceneMailer)
			scene_email_composer.send_next_scene
		end
	end

end