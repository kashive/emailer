require 'rubygems'
require 'nokogiri'
require 'mechanize'

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}
adminAndEmail = {}
clubAndAdmin = {}
clubTypeAndClub = {}

a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
a.get('http://www.brandeis.edu/clubs/index.html') do |mainPage|
	mainPage.links[80..-3].each do |clubCategoryLink|
		clubCategory = clubCategoryLink.text();
		clubCategoryLink.click().links()[93..-1].each do |googlePageLink|
			clubName = googlePageLink.text();
			googlePageLink.click().links_with(:href=>/directory/).each do |clubAdminBrandeisDirectory|
				adminName = clubAdminBrandeisDirectory.text();
				begin
					clubAdminBrandeisDirectory.click().links_with(:href=>/mailto/).each do |clubAdminEmail|
						adminEmail = clubAdminEmail.text();
						adminAndEmail[adminName] = adminEmail;
					end
				rescue Mechanize::ResponseCodeError => exception
					if exception.response_code == '403'
						adminEmail = "Exception Raised"
						adminAndEmail[adminName] = adminEmail;
					end
				end	
			end
			clubAndAdmin[clubName] = adminAndEmail;
			adminAndEmail = {};
		end
		clubTypeAndClub[clubCategory] = clubAndAdmin;
		clubAndAdmin={};
		# puts clubTypeAndClub.inspect
		# puts
	end
end
# puts courseTimings.inspect
File.open('clubLeadersEmail','w') do|file|
 Marshal.dump(clubTypeAndClub, file)
end