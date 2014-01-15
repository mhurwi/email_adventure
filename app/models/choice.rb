class Choice
	include Mongoid::Document

	field :text
	field :target_scene_id


	belongs_to :scene

	def target_scene
		Scene.find(self.target_scene_id)
	end

	def target_scene_is_final?
		self.target_scene.final?
	end
end