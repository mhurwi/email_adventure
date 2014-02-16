class Story
	include Mongoid::Document

	field :title

	field :user_id
	
	belongs_to :user

	has_and_belongs_to_many :player_accounts

	has_many :scenes
	accepts_nested_attributes_for :scenes, allow_destroy: true

end