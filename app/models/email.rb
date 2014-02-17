class Email
	include Mongoid::Document

	field :to
	field :from
	field :body
	
end