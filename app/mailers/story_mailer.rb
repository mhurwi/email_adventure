class StoryMailer < ActionMailer::Base

  def confirm_start(story, player_account)
  	@story = story
  	@player = player_account

  	# delivery_options = DEFAULTS

  	mail( to: @player.email,
          from: "hello@emailadventure.com",
  				subject: "Ready to play '#{@story.title}'? Confirm!"
  				# delivery_method_options: delivery_options
  			)
  end

end
