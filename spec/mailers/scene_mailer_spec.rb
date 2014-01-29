require "spec_helper"

describe SceneMailer do
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
	let(:player) { OpenStruct.new(email: "player@example.com")} 	
 	let(:sent_intro_email) { SceneMailer.intro_scene(
 				story, scene, character, player
 				).deliver}
	context "intro_scene" do 
 		it "sends the intro scene" do 
 			sent_intro_email
 			expect(ActionMailer::Base.deliveries.count).to eql 1
 		end
 		it "users players address" do 
 			expect(sent_intro_email.to).to eql ["player@example.com"]
 		end
 	end

 	context "next_scene" do 
 		it "sends the next scene"
 	end

 	context "required data" do 
 		it "includes the story_id"
 		it "includes the scene_id"
 		it "sets the smtp_settings"
 	end
end
