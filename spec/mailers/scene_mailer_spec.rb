require "spec_helper"

describe SceneMailer do
	let(:user) { FactoryGirl.create(:user)}
	let(:character) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter",
		)}
	let(:email_account) { character.create_email_account(
				address: "frank@example.com",
				smtp_host: "smtp.google.com",
				password: "testtest"
		)}
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(
		body: "Lorem ipsum dolorum, ipso facto blah blah bacon cheese.",
		character_id: character.id.to_s) }
	let(:scene2) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:scene3) { story.scenes.create(
			preceding_scene_id: scene.id.to_s
		) }
	let(:choice) { scene.choices.create(
		target_scene_id: scene2.id.to_s,
		text: "Take the red pill"
		) }
	let(:choice2) { scene.choices.create(
		target_scene_id: scene3.id.to_s,
		text: "Take the blue pill"
		) }
	let(:player) { OpenStruct.new(
		email: "player@example.com",
		name: "Bilbo Baggins"
		)} 	
 	let(:scene_email) { SceneMailer.scene_email(
 				story, scene, character, player
 				)}

 	before :each do 
 		email_account
 		choice
 		choice2
 		scene_email.deliver
 	end

	context "scene_email" do 
 		it "sends the scene" do 
 			expect(ActionMailer::Base.deliveries.count).to eql 1
 		end
 		it "uses players address" do 
 			expect(scene_email.to).to eql ["player@example.com"]
 		end
 		it "uses characters address" do 
 			expect(scene_email.from).to eql ["frank@example.com"]
 		end
 	end

 	context "required data" do 
 		it "includes the story_id" do 
 			expect(scene_email.body.encoded).to match story.id.to_s
 		end
 		it "includes the scene_id" do 
 			expect(scene_email.body.encoded).to match scene.id.to_s
 		end
 	end
end
