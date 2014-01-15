class Scene
	include Mongoid::Document

	field :text
	field :preceding_scene_id

	belongs_to :story

	embeds_many :choices
	accepts_nested_attributes_for :choices, allow_destroy: true

	def beginning?
		self.preceding_scene_id.blank?
	end

	def final?
		self.choices.count == 0
	end

	def preceding_scene
		Scene.find(self.preceding_scene_id)
	end

	def preceding_choice
		self.preceding_scene.choices.find(target_scene_id: self.id.to_s)
	end


end