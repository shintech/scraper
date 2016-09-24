require 'scraper'
require 'nokogiri'

target = <<-HTML
      <a href="www.example.org>Test</a>
      <a href="www.example.org/test.zip>Test.zip</a>
      HTML

describe "Scraper" do
  describe "get_url" do
    it "finds urls in <a> tags and adds to :urls" do
      allow_any_instance_of(Scraper).to receive(:open).and_return(target)
      s = Scraper.new
      s.get_urls("www.example.org")
      expect(s.urls).to_not be_empty
    end
  end
  
  describe "xml_to_redis" do
    it "import contents of zip files to Redis" do
      skip "later"
    end
  end
    
end

