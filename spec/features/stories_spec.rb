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

	describe "NEW /stories" do 
		before :each do 
			story
			visit new_story_path
		end

		it "has form" do 
			expect(page).to have_content 'Title' 
		end

		it "creates saves a new story after entering title" do 
			fill_in 'story[title]', with: 'One Million Monkeys'
			click_button 'Create Story'
			expect(page).to have_content 'One Million Monkeys'
		end
	end

	describe "GET /stories/:id" do 
		before :each do 
			visit story_path(story)
		end
		context "starting with 0 scenes" do 
			it "has button to create intro scene" do 
				expect(page).to have_content "Create introduction"
			end

			it "goes to new scene page" do 
				click_link "Create introduction"
				expect(current_path).to eql new_story_scene_path(story)
			end
		end
	end

end