class SceneEmailComposer
	include ActiveAttr::Model

	attribute :story
	attribute :scene
	attribute :character
	attribute :player


	# This model takes the components of
	# an email and gets them ready for the 
	# scene mailer.
	# 
	# It will be called in 2 situations:
	# - when a player signs up to start a new story
	# - in response to an incoming reply from a player
	#
	# In either case, the mailer will need:
	# story_id
	# scene_id
	# scene.subject
	# scene.body
	# scene.choices.each {|c| c.text }
	# character.name
	# character.address
	# character.email_account
	# player.email
	# 
	# After the mail is sent, some other model
	# needs to update the player according to
	# the choice they made and where they are in the 
	# story.

	def send_scene_email
		SceneMailer.scene_email(
			self.story, 
			self.scene, 
			self.character,
			self.player
			).deliver
	end


end