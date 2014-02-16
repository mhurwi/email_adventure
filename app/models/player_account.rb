class PlayerAccount
	include Mongoid::Document

	field :email
	field :confirmation_token


	has_and_belongs_to_many :stories
	belongs_to :user, inverse_of: :player_account

	def self.find_or_create_by_email(email)		
		if belongs_to_existing_user?(email)
			User.find_by(email: email).player_account	
		else
			PlayerAccount.create(
				email: email,
				confirmation_token: generate_confirmation_token)
		end
	end

	def self.generate_confirmation_token
		SecureRandom.urlsafe_base64(32)
	end

	def self.belongs_to_existing_user?(email)
		begin
			User.find_by(email: email)
		rescue
			false
		end
	end

	def associate_with_user(user_id)
		User.find(user_id).update_attributes(
				player_account: self
			)
	end

	def add_story(story_id)
		story = Story.find(story_id)
		self.stories.push(story)
		story.player_accounts.push(self)
	end

end