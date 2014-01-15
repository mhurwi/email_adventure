class Story
	include Mongoid::Document

	field :title

	has_many :scenes
	accepts_nested_attributes_for :scenes, allow_destroy: true

end