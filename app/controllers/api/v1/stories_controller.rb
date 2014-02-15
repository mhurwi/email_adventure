module Api
	module V1
		class StoriesController < ApiController

			# We want to allow JSON requests to this controller
			skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

			def start_story
				@greeting = "Thanks #{params[:email]}!"

				# TODO: get this thing started!
				# create user, update the story he's starting, send the email.

				respond_to do |format|
					format.json { render json: {"message" => @greeting } }
				end
			end

		end
	end
end