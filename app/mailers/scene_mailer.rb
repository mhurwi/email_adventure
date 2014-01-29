class SceneMailer < ActionMailer::Base
  default from: "from@example.com"

  def intro_scene(story, scene, character, player)
  	mail 	to: player.email
  				# subject: scene.subject
  end

  def next_scene(story, scene, character, player)
  	
  end
end
