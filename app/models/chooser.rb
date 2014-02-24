class Chooser

	attr_reader :email
	attr_accessor :player_email,
								:story, 
								:scene, 
								:choice_text


	# These class variables tell us where we can 
	# find the information we need. This is liable
	# to change as we refine our SceneMailer and 
	# our Choosing Algorithm
	@@mark_reply_end = "--- REPLY ABOVE THIS LINE ---"

	@@mark_story_id_start = "story_id:"
	@@mark_story_id_end = "/story_id"

	@@mark_scene_id_start = "scene_id:"
	@@mark_scene_id_end = "/scene_id"

	def initialize(email)
		@email = email
	end


	# Parse email is the main method that 
	# tells us which story and scene the player
	# replied to and the text of their reply.
	def parse_email
		self.player_email = self.email.from
		self.story = Story.find(extract_story_id)
		self.scene = Scene.find(extract_scene_id)
		self.choice_text = extract_choice.downcase
	end


	#################
	# Private Methods
	def extract_story_id
    self.email.body[/#{Regexp.escape(@@mark_story_id_start)}(.*?)#{Regexp.escape(@@mark_story_id_end)}/m, 1]
  end

  def extract_scene_id
    self.email.body[/#{Regexp.escape(@@mark_scene_id_start)}(.*?)#{Regexp.escape(@@mark_scene_id_end)}/m, 1]
  end

  def extract_choice
    self.email.body.gsub("\n", "")[/(.*?)#{Regexp.escape(@@mark_story_id_start)}/m, 1]
  end

end