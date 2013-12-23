class EmailerController < ApplicationController
  def create
  	@email = Email.new
  	file = File.open("script/clubLeaders.txt", "rb")
  	contents = file.read
  	file.close
  	@clubLeaders = JSON.parse(contents)
  end

  def nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end

  def findCategory(data,clubName)
    data.keys.each do |clubCategory|
      data[clubCategory].keys.each do |clubTitle|
        return clubCategory if clubTitle == clubName
      end
    end
  end

  def publish
  	emailAddresses = []
  	club_categories = ["Academic", "Arts_and_Culture","Competition","Media_and_Publications",
  		"Miscellaneous", "Performance","Political_and_Activism","Service","Spiritual_and_Religious","Sports"]
  	file = File.open("script/clubLeaders.txt", "rb")
  	contents = file.read
  	file.close
  	@clubLeaders = JSON.parse(contents)
  	categoriesAndClubs = params.map{ |k,v| v=='yes' ? k : nil }.compact
  	onlyClubs = categoriesAndClubs - club_categories
  	onlyClubs.each do |club_name|
     club_name = club_name.gsub("_"," ")
     nameAndEmail = nested_hash_value(@clubLeaders,club_name)
     break if nameAndEmail == nil
     clubCategory = findCategory(@clubLeaders, club_name)
     nameAndEmail.each do |name,email|
      first_name = name.split[0]
      last_name = name.split[1]
      initialMessage = params[:email][:message]
      initialMessage = initialMessage.gsub("#first_name",first_name)
      initialMessage = initialMessage.gsub("#last_name",last_name)
      initialMessage = initialMessage.gsub("#club_name",club_name)
      initialMessage = initialMessage.gsub("#category_name",clubCategory)
      logger.debug "Message: #{initialMessage.inspect}"
      # send email here
      Broadcast.broadcast_message(initialMessage, "avishek@brandeis.edu").deliver
     end 
  	end
    redirect_to root_path, notice: 'emails were successfully sent'
  end
end