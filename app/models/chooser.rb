class Chooser

	attr_reader :email

	@@mark_reply_end = "--- REPLY ABOVE THIS LINE ---"

	@@mark_story_id_start = "story_id:"
	@@mark_story_id_end = "/story_id"

	@@mark_scene_id_start = "scene_id:"
	@@mark_scene_id_end = "/scene_id"

	def initialize(email)
		@email = email
	end

	def parse_email
		
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

end