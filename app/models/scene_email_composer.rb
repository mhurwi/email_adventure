class SceneEmailComposer
	include ActiveAttr::Model

	attribute :story
	attribute :scene
	attribute :character
	attribute :recipient


	# This model takes the components of
	# an email and gets them ready for the 
	# scene mailer.
	# 
	# It will be called by the email_processor
	# in response to an incoming reply from a player
	#
	# Or, it will be called by the email API 
	# when a player signs up to start a new story.
	#
	# In either case, the mailer will need:
	# story_id
	# scene_id
	# scene.subject
	# sceene.body
	# scene.choices.each {|c| c.text }
	# character.name
	# character.address
	# character.email_account
	# recipient.email

	def send_next_scene
		SceneMailer.next_scene(
			self.story, 
			self.scene, 
			self.character,
			self.recipient
			).deliver
	end

	def send_intro_scene
		SceneMailer.intro_scene(
			self.story, 
			self.scene, 
			self.character,
			self.recipient
			).deliver
	end

end