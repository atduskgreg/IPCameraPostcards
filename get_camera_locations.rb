require 'geokit'

Dir.glob("img_urls/*.txt").each do |file|
  open(file).read.split(/\n/).each do |url|
    host = URI.parse(url).host
    geo = Geokit::Geocoders::MultiGeocoder.geocode(host)

    File.open("geo_results.csv", "a"){|f| f << "\"#{url}\",\"#{geo.full_address}\"\n"}
  end
end