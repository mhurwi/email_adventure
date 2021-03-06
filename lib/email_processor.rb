class EmailProcessor
  def self.process(email)
    puts "==============================================="
    puts "Receiving email:" 
    puts "from: #{ email.from }"
    puts "to: #{ email.to }"
    puts "body: #{email.body }"

    Email.create( 
    	to: email.to, 
    	from: email.from, 
    	subject: email.subject,
    	body: email.body,
    	raw_body: email.raw_body,
    	raw_headers: email.raw_headers ) 
    # todo: send the email to SceneChooser
    # SceneChooser can figure out:
    # -- the player
    # -- what story he is playing
    # -- what scene he is replying to
    # -- what his reply is
    # and then it can send the next appropriate scene.
    Chooser.new(email: email).perform
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