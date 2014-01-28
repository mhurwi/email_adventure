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
	let(:scene_email_composer) { SceneEmailComposer.new(
				story: story,
				scene: scene,
				character: character,
				recipient: "player@example.com"
			)}

	it "gets story" do
		expect(scene_email_composer.story).to eq story
	end


end