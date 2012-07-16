class FbPostToWall::OpenGraphProxyController < ApplicationController

	def page_info
		@info = OpenGraphParser.get_elements(params["url"])

		respond_to do |format|
			format.html
			format.xml { render :xml => @info }
			format.js
			format.json { render :json => @info }
		end
	end

end
