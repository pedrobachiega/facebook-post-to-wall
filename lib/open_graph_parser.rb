require 'nokogiri'
require 'open-uri'

module OpenGraphParser

	def self.get_elements(url)
		elements = {}
		doc = Nokogiri::HTML(open(url))

		doc.css("meta[property='og:url']").each do |element|
			elements.merge!('url' => element.attributes["content"].value)
		end
		unless elements['url']
			elements.merge!('url' => url)
		end

		doc.css("meta[property='og:title']").each do |element|
			elements.merge!('title' => element.attributes["content"].value)
		end
		unless elements['title']
			doc.css("title").each do |element|
				elements.merge!('title' => element.content)
			end
		end

		doc.css("meta[property='og:description']").each do |element|
			elements.merge!('description' => element.attributes["content"].value)
		end
		unless elements['description']
			doc.css("meta[name='description']").each do |element|
				elements.merge!('description' => element.attributes["content"].value)
			end
		end

		doc.css("meta[property='og:image']").each do |element|
			elements.merge!('image' => element.attributes["content"].value)
		end
		unless elements['image']
			imgs = []
			doc.css("img").each do |element|
				src = element.attributes["src"].value
				imgs << (src.starts_with?('http') ? src : url+src)
			end
			elements.merge!('image' => imgs)
		end

		elements
	end

end
