class EmailAccount
	include Mongoid::Document

	field :address

	# SMTP settings
	field :user_name # API key from sendgrid, or mandrill, or etc
	field :port
	field :smtp_address
	field :domain
	field :password
	field :authentication
	field :enable_starttls_auto, default: true


	belongs_to :character, inverse_of: :email_account

# has_one: :smtp_settings, inverse_of: :email_account
# accepts_nested_attributes_for :smtp_settings, allow_destroy: true

# smtp_settings
# :address - Allows you to use a remote mail server. Just change it from its default "localhost" setting.
# :port - On the off chance that your mail server doesn't run on port 25, you can change it.
# :domain - If you need to specify a HELO domain, you can do it here.
# :user_name - If your mail server requires authentication, set the username in this setting.
# :password - If your mail server requires authentication, set the password in this setting.
# :authentication - If your mail server requires authentication, you need to specify the authentication type here. This is a symbol and one of :plain, :login, :cram_md5.
# :enable_starttls_auto - Set this to false if there is a problem with your server certificate that you cannot resolve.
	
	# Example:
	# character.smtp_settings = {
	#   address:              'smtp.gmail.com',
	#   port:                 587,
	#   domain:               'example.com',
	#   user_name:            '<username>',
	#   password:             '<password>',
	#   authentication:       'plain',
	#   enable_starttls_auto: true  }

end