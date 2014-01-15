require 'spec_helper'

describe Story do 
	let(:story) { Story.new }

	it "has a name" do 
		story.title = "Test Story"
		expect(story.title).to eql "Test Story"
	end

	it "has many scenes" do 
		story.save
		scene = story.scenes.create
		expect(story.scenes.first).to eql scene
	end

end