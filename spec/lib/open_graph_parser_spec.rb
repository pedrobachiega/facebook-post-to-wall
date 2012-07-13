#coding: utf-8

require 'spec_helper'

describe 'OpenGraphParser' do

	it "gets html tags" do
	  elements = OpenGraphParser.get_elements('https://www.google.com.br')
	  elements['url'].should eq("https://www.google.com.br")
	  elements['title'].should eq("Google")
	  elements['description'].should be_nil
	  elements['image'].should be_an_instance_of Array
	  elements['image'][0].should eq("https://www.google.com.br/textinputassistant/tia.png")
	end

	it "gets og tags" do
	  elements = OpenGraphParser.get_elements('http://sandbox.pedrobachiega.com/rd-blog-index.html')
	  elements['url'].should eq("http://resultadosdigitais.com.br")
	  elements['title'].should eq("Resultados Digitais")
	  elements['description'].should eq("Marketing Digital de resultados para PMEs. Falamos de SEO, mídias sociais, blog, geração de Leads, vendas, email marketing, monitoramento, análise e otimização.")
	  elements['image'].should eq("http://resultadosdigitais.com.br/arte/ResultadosDigitais.jpg")
	end

end
