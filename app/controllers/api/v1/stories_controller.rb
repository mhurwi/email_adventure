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

			# After the player receives his 'confirmation' email,
			# he clicks the link in the email and hits this action.
			# We redirect from here to the main Stories Controller,
			# where we actually start his story and send 
			# his first email.
			def confirm_start
				@player_account = PlayerAccount.find(params[:player_account_id])
				@story = Story.find(params[:story_id])
				respond_to do |format|
					if params[:confirmation_token] == @player_account.confirmation_token
						format.json { redirect_to story_confirmation_success_path(@story.id.to_s) }
					else
						flash[:error] = "Sorry!  Your confirmation link seems incorrect."
						format.json { redirect_to root_path}
					end
				end
			end

		end
	end
end