class Character
	include Mongoid::Document

	field :first_name
	field :last_name

	has_one :email_account, inverse_of: :character
	accepts_nested_attributes_for :email_account, allow_destroy: true

	belongs_to :user, inverse_of: :characters
	belongs_to :scene

	def scenes
		Scene.where(character_id: self.id.to_s)
	end
end