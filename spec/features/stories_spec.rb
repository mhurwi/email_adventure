require 'spec_helper'

describe 'Stories' do 
	let(:story) { FactoryGirl.create(:story) }
	describe 'GET /stories' do 
		before :each do 
			story
			visit stories_path
		end
		it "works!" do 
			expect(page).to have_content 'Create new story'
		end

		it "has story titles" do 
			expect(page).to have_content 'Test Story'
		end

		it "has links to story show page" do
			click_link "Test Story"
			expect(current_path).to eql story_path(story)
		end

		it "can go to create new story page" do 
			click_link 'Create new story'
			expect(current_path).to eql new_story_path
		end
	end

end