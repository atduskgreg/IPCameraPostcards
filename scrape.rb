require 'nokogiri'
require 'open-uri'

insecam = "http://www.insecam.org"
categories = ["River", "Beach", "Nature", "Architecture", "City", "Road"]


categories.each do |cat|
  puts "Starting Category: #{cat}"
  page_url = insecam + "/cam/bytag/#{cat.downcase}"

  doc = Nokogiri::HTML(open(page_url).read)

  ## TODO: handle pagination

  doc.css(".thumbnail a").collect{|link| link.attributes["href"].value}.each do |cam_page_path|
    cam_page_url = "#{insecam}#{cam_page_path}"
    
    cam_doc = Nokogiri::HTML(open(cam_page_url).read)
    stream_links = cam_doc.css("a").select{|l| l.attributes["rel"] && l.attributes["rel"].value == "nofollow"}
    if stream_links.length > 0
      cam_url = stream_links[0].attributes["href"].value
      img_url = stream_links[0].children.select{|n| n.name == "img"}[0].attributes["src"].value

      # puts cam_url
      File.open("img_urls/#{cat.downcase}.txt", "a"){|f| f << img_url + "\n"}
    end

    # `cd grabs; wget #{img_url}`
  end
end

