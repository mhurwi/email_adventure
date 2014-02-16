module Api
	module V1
		class StoriesController < ApiController

			# We want to allow JSON requests to this controller
			skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

			def start_story
				email = params[:email]
				@story = Story.find(params[:story_id])
				@player_account = ::PlayerAccount.find_or_create_by_email(email)
				StoryMailer.confirm_start(@story, @player_account).deliver
				respond_to do |format|
					format.json { render json: {
																				"message" => "Thanks #{email}! Look for your confirmation email!",
																				"story" => @story.title
																			} 
																		}
				end
			end

			def confirm_start
				@player_account = PlayerAccount.find(params[:player_account_id])
				@story = Story.find(:story_id)
				respond_to do |format|
					if params[:confirmation_token] == @player_account.confirmation_token
							@player_account.add_story(@story)
							SceneMailer.scene_email(
								@story, 
								@story.scenes.first, 
								@story.scenes.first.character,
								@player_account
							).deliver
							format.html # confirm_start page
					else
							flash[:error] = "Sorry!  Your confirmation link seems incorrect."
							redirect_to root_path
					end
				end
			end



		end
	end
end