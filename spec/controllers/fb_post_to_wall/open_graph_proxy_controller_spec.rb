require 'spec_helper'

describe FbPostToWall::OpenGraphProxyController do

	describe "GET /page-info" do

		before(:each) do
			@params = { :url => "http://some-url.html" }
			@info = { "url" => "http://some-url.html", "title" => "Title #{rand(99)}", "description" => "Meta description", "image" => "http://image.com.png" }
			OpenGraphParser.stub(:get_elements).and_return(@info)
		end

		it "call retriever" do
			OpenGraphParser.should_receive(:get_elements).with(@params[:url]).and_return(@info)
			get 'page_info', @params
		end

		it "returns data" do
			get 'page_info', @params
			assigns(:info).should eq(@info)
		end
		
		context "by json" do

			it "returns data" do
				get 'page_info', @params.merge(:format => "json")
				json_response(response)["content"].should eq(assigns(:info).as_json["content"])
			end

		end

	end

end
