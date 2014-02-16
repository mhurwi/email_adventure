class StoryMailer < ActionMailer::Base

  def confirm_start(story, player_account)
  	@story = story
  	@player = player_account


  	mail( 
      to: @player.email,
      from: "marlene@emailadventure.com",
			subject: "Ready to play '#{@story.title}'? Confirm!"
  	)
  end

end
