require 'happymapper'


cklist = '/Users/rxman/Documents/MITRE/INSPEC/inspec2xccdf/data/xccdf.xml'
doc = File.open(cklist) { |f| Nokogiri::XML(f) }
puts doc
xml = HappyMapper.parse(doc)
