require 'spec_helper'

describe Story do 
	let(:story) { Story.new }
	let(:user) { FactoryGirl.create(:user)}
	it "has a name" do 
		story.title = "Test Story"
		expect(story.title).to eql "Test Story"
	end

	it "has many scenes" do 
		story.save
		scene = story.scenes.create
		expect(story.scenes.first).to eql scene
	end

	context "user" do 
		it "has a user" do 
			story.user = user.id.to_s
			expect(story.user.email).to eq "example@example.com"		
		end
	end

end