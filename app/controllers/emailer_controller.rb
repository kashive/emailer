class EmailerController < ApplicationController
  def create
  	@email = Email.new
  	file = File.open("script/clubLeaders.txt", "rb")
	contents = file.read
	file.close
	@clubLeaders = JSON.parse(contents)
  end

  def publish
  	emailAddresses = []
  	club_categories = ["Academic", "Arts_and_Culture","Competition","Media_and_Publications",
  		"Miscellaneous", "Performance","Political_and_Activism","Service","Spiritual_and_Religious","Sports"]
  	file = File.open("script/clubLeaders.txt", "rb")
	contents = file.read
	file.close
	@clubLeaders = JSON.parse(contents)
	debugger
  	categoriesAndClubs = params.map{ |k,v| v=='yes' ? k : nil }.compact
  	onlyClubs = categoriesAndClubs - club_categories
  	onlyClubs.each do |club_name|
  		# send email here
  	end
  end
end