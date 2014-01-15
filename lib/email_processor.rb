class EmailProcessor
  def self.process(email)
    # all of your application-specific code here - creating models,
    # processing reports, etc
  end

  # The email object contains the following attributes:
		# to
		# from
		# subject
		# body
		# raw_body

	# The contents of the email object passed into your process method is an object that responds to:
	# 	.to
	# 	.from
	# 	.cc
	# 	.subject
	# 	.body
	# 	.raw_text
	# 	.raw_html
	# 	.raw_body
	# 	.attachments
	# 	.headers
	# 	.raw_headers

	# .body will contain the full contents of the email body unless there is 
	# a line in the email containing the string -- Reply ABOVE THIS LINE --. In that 
	# case .body will contain everything before that line.
end