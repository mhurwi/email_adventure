# each email should belong to a SceneChooser
# The SceneChooser will use the email to get the 
# player
# story
# scene
# possible choices
# player's response

class Email
	include Mongoid::Document

	field :to
	field :from
	field :subject
	field :body
	field :raw_body
	field :raw_headers

end