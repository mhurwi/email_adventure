class StoryMailer < ActionMailer::Base

  def confirm_start(story, player_account)
  	@story = story
    @character = story.default_character
    @player = player_account
  	   
    delivery_options = { 
                          user_name: @character.full_name
                        }

    mail( to: @player.email,
          from: @character.email_account.address,
          subject: "Ready to play '#{@story.title}'? Confirm!",
          delivery_method_options: delivery_options
        )
  end

end
