class SceneMailer < ActionMailer::Base

  def scene_email(story, scene, character, player)
  	@story = story
  	@scene = scene
  	@character = character
  	@email_account = @character.email_account
  	@player = player

  	delivery_options = { 
  												user_name: @character.full_name,
  												# password: @email_account.password,
  												# address: @email_account.smtp_host
  											}

  	mail( to: @player.email,
          from: @email_account.address,
  				subject: @scene.subject,
  				delivery_method_options: delivery_options
  			)
  end

end
