require 'spec_helper'

describe "fb_post_to_wall/open_graph_proxy/page_info.html.erb" do

  describe "simple data" do

    before(:each) do
      @info = { "url" => "http://some-url.html", "title" => "Title #{rand(99)}", "description" => "Meta description", "image" => "http://image.com.png" }
      assign(:info, @info)
    end

    it "renders info" do
      render
      rendered.should have_selector("label.title", :text => @info["title"])
      rendered.should have_selector("label.url", :text => @info["url"])
      rendered.should have_selector("label.desc", :text => @info["description"])
    end

    it "renders one image" do
      render
      rendered.should have_selector(:xpath, ".//img[@class=\"fbpw_img\"]", :count => 1)
      rendered.should have_selector(:xpath, ".//img[@id=\"fbpw_img_1\"][@src=\"#{@info["image"]}\"]")
      rendered.should have_selector(:xpath, ".//input[@id=\"fbpw_total_imgs\"][@value=\"1\"]")
    end

    it "hasn't total and navigation" do
      render
      rendered.should_not have_content("1 of 1")
      rendered.should_not have_selector(:xpath, ".//div[@id=\"fbpw_info\"]//div")
    end

  end

  describe "complex data" do

    before(:each) do
      @info = { "url" => "http://some-url.html", "title" => "Title #{rand(99)}", "description" => "Meta description", "image" => [ "http://image1.com.png", "http://image2.com.png", "http://image3.com.png" ] }
      assign(:info, @info)
    end

    it "renders images" do
      render
      rendered.should have_selector(:xpath, ".//img[@id=\"fbpw_img_1\"][@src=\"#{@info["image"][0]}\"]")
      rendered.should have_selector(:xpath, ".//img[@id=\"fbpw_img_2\"][@src=\"#{@info["image"][1]}\"]")
      rendered.should have_selector(:xpath, ".//img[@id=\"fbpw_img_3\"][@src=\"#{@info["image"][2]}\"]")
      rendered.should have_selector(:xpath, ".//input[@id=\"fbpw_total_imgs\"][@value=\"3\"]")
    end

    it "renders total and navigation" do
      render
      rendered.should have_selector(:xpath, ".//a[@id=\"fbpw_prev_img\"]")
      rendered.should have_selector(:xpath, ".//a[@id=\"fbpw_next_img\"]")
      rendered.should have_content("1 of 3")
    end

  end

end
