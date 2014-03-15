class Chooser
	include ActiveAttr::Model

	attribute :email
	attribute :player
	attribute :story
	attribute :scene
	attribute :next_scene
	attribute :choice_text
	attribute :choice

	validates_presence_of :email


	# These class variables tell us where we can 
	# find the information we need. This is liable
	# to change as we refine our SceneMailer and 
	# our Choosing Algorithm
	@@mark_reply_end = "--- REPLY ABOVE THIS LINE ---"

	@@mark_story_id_start = "story_id:"
	@@mark_story_id_end = "/story_id"

	@@mark_scene_id_start = "scene_id:"
	@@mark_scene_id_end = "/scene_id"



	def perform
		parse_email
		choose_next_scene
		send_email
	end



	##############################
	# Parse and Extract from Email
	# Setup the attributes for this email
	def parse_email
		self.player = User.find_by(email: self.email.from)
		self.story = Story.find(extract_story_id)
		self.scene = Scene.find(extract_scene_id)
		self.choice_text = extract_choice.downcase
	end

	def extract_story_id
    self.email.body[/#{Regexp.escape(@@mark_story_id_start)}(.*?)#{Regexp.escape(@@mark_story_id_end)}/m, 1]
  end

  def extract_scene_id
    self.email.body[/#{Regexp.escape(@@mark_scene_id_start)}(.*?)#{Regexp.escape(@@mark_scene_id_end)}/m, 1]
  end

  def extract_choice
    self.email.body.gsub("\n", "")[/(.*?)#{Regexp.escape(@@mark_story_id_start)}/m, 1]
  end



  ############################
  # Choose and Send Next Scene
  def choose_next_scene
  	self.choice = scene.choices.find_by(text: choice_text)
  	self.next_scene = Scene.find(choice.target_scene_id)
  end

  def send_email
  	SceneMailer.scene_email(
				story, 
				next_scene, 
				player
			).deliver
  end

end