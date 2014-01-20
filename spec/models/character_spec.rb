require 'spec_helper'

describe Character do 

	it "has a first name" do 
		character = Character.new(first_name: "Frank")
		expect(character.first_name).to eq "Frank"
	end

end