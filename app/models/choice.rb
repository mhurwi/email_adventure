class Choice
	include Mongoid::Document

	field :text
	field :target_scene_id


	belongs_to :scene

	def target_scene
		Scene.find(self.target_scene_id)
	end

	def leads_to_final_scene?
		self.target_scene.final?
	end
end