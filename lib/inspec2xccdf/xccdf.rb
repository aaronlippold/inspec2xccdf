#!/usr/local/bin/ruby
# encoding: utf-8
# author: Aaron Lippold
# author: Rony Xavier rx294@nyu.edu

require 'happymapper'
require 'nokogiri'

# see: https://github.com/dam5s/happymapper
# Class Asset maps from the 'Asset' from Checklist XML file using HappyMapper
# class Asset
#   include HappyMapper
#   tag 'ASSET'
#   element :role, String, tag: 'ROLE'
#   element :type, String, tag: 'ASSET_TYPE'
#   element :host_name, String, tag: 'HOST_NAME'
#   element :host_ip, String, tag: 'HOST_IP'
#   element :host_mac, String, tag: 'HOST_MAC'
#   element :host_guid, String, tag: 'HOST_GUID'
#   element :host_fqdn, String, tag: 'HOST_FQDN'
#   element :tech_area, String, tag: 'TECH_AREA'
#   element :target_key, String, tag: 'TARGET_KEY'
#   element :web_or_database, String, tag: 'WEB_OR_DATABASE'
#   element :web_db_site, String, tag: 'WEB_DB_SITE'
#   element :web_db_instance, String, tag: 'WEB_DB_INSTANCE'
# end
#
# # Class Asset maps from the 'SI_DATA' from Checklist XML file using HappyMapper
# class SI_DATA
#   include HappyMapper
#   tag 'SI_DATA'
#   element :name, String, tag: 'SID_NAME'
#   element :data, String, tag: 'SID_DATA'
# end
#
# #Class Asset maps from the 'STIG_INFO' from Checklist XML file using HappyMapper
# class StigInfo
#   include HappyMapper
#   tag 'STIG_INFO'
#   has_many :si_data, SI_DATA, tag: 'SI_DATA'
# end
#
# #Class Asset maps from the 'STIG_DATA' from Checklist XML file using HappyMapper
# class StigData
#   include HappyMapper
#   tag 'STIG_DATA'
#   has_one :attrib, String, tag: 'VULN_ATTRIBUTE'
#   has_one :data, String, tag: 'ATTRIBUTE_DATA'
# end
#
# # Class Asset maps from the 'VULN' from Checklist XML file using HappyMapper
# class Vuln
#   include HappyMapper
#   tag 'VULN'
#   has_many :stig_data, StigData, tag:'STIG_DATA'
#   has_one :status, String, tag: 'STATUS'
#   has_one :finding_details, String, tag: 'FINDING_DETAILS'
#   has_one :comments, String, tag: 'COMMENTS'
#   has_one :severity_override, String, tag: 'SEVERITY_OVERRIDE'
#   has_one :severity_justification, String, tag: 'SEVERITY_JUSTIFICATION'
# end
#
# # Class Asset maps from the 'iSTIG' from Checklist XML file using HappyMapper
# class IStig
#   include HappyMapper
#   tag 'iSTIG'
#   has_one :stig_info, StigInfo, tag: 'STIG_INFO'
#   has_many :vuln, Vuln, tag: 'VULN'
# end
#
# # Class Asset maps from the 'STIGS' from Checklist XML file using HappyMapper
# class Stigs
#   include HappyMapper
#   tag 'STIGS'
#   has_one :istig, IStig, tag: 'iSTIG'
# end

class Status
  include HappyMapper
  tag 'status'
  attribute :date, String, tag: 'date'
  content :status, String, tag: 'status'
end

class Notice
  include HappyMapper
  tag 'notice'
  attribute :id, String, tag: 'id'
  attribute :xml_lang, String, namespace: 'xml', tag: 'lang'
  content :notice, String, tag: 'notice'
end

class ReferenceBenchmark
  include HappyMapper
  tag 'reference'
  attribute :href, String, tag: 'href'
  element :dc_publisher, String, namespace: 'dc', tag: 'publisher'
  element :dc_source, String, namespace: 'dc', tag: 'source'
end

class ReferenceGroup
  include HappyMapper
  tag 'reference'
  element :dc_title, String, namespace: 'dc', tag: 'title'
  element :dc_publisher, String, namespace: 'dc', tag: 'publisher'
  element :dc_type, String, namespace: 'dc', tag: 'type'
  element :dc_subject, String, namespace: 'dc', tag: 'subject'
  element :dc_identifier, String, namespace: 'dc', tag: 'identifier'
end

class Plaintext
  include HappyMapper
  tag 'plain-text'
  attribute :id, String, tag: 'id'
  content :plaintext, String
end

class Select
  include HappyMapper
  tag 'Select'
  attribute :idref, String, tag: 'idref'
  attribute :selected, String, tag: 'selected'
end

class Ident
  include HappyMapper
  tag 'ident'
  attribute :system, String, tag: 'system'
  content :ident, String
end

class Fixtext
  include HappyMapper
  tag 'fixtext'
  attribute :fixref, String, tag: 'fixref'
  content :fixtext, String
end

class Fix
  include HappyMapper
  tag 'fixtext'
  attribute :id, String, tag: 'id'
end

class ContentRef
  include HappyMapper
  tag 'check-content-ref'
  attribute :name, String, tag: 'name'
  attribute :href, String, tag: 'href'
end

class Check
  include HappyMapper
  tag 'check'
  attribute :system, String, tag: 'system'
  element :content_ref, ContentRef, tag: 'check-content-ref'
  element :content, String, tag: 'check-content'
end

class Profile
  include HappyMapper
  tag 'Profile'
  attribute :id, String, tag: 'id'
  element :title, String, tag: 'title'
  element :description, String, tag: 'description'
  has_many :select, Select, tag: 'select'
end

class Rule
  include HappyMapper
  tag 'Rule'
  attribute :id, String, tag: 'id'
  attribute :severity, String, tag: 'severity'
  attribute :weight, String, tag: 'weight'
  element :version, String, tag: 'version'
  element :title, String, tag: 'title'
  element :description, String, tag: 'description'
  has_many :select, Select, tag: 'select'
  element :reference, ReferenceGroup, tag: 'reference'
  has_many :ident, Ident, tag: 'ident'
  element :fixtext, Fixtext, tag: 'fixtext'
  element :fix, Fix, tag: 'fix'
  element :check, Check, tag: 'check'
end

class Group
  include HappyMapper
  tag 'Group'
  attribute :id, String, tag: 'id'
  element :title, String, tag: 'title'
  element :description, String, tag: 'description'
  element :rule, Rule, tag: 'Rule'
end

class Benchmark
  include HappyMapper
  tag 'Benchmark'
  register_namespace 'dsig', "http://www.w3.org/2000/09/xmldsig#"
  register_namespace 'xsi', "http://www.w3.org/2001/XMLSchema-instance"
  register_namespace 'cpe', "http://cpe.mitre.org/language/2.0"
  register_namespace 'xhtml', "http://www.w3.org/1999/xhtml"
  register_namespace 'dc', "http://purl.org/dc/elements/1.1/"
  attribute :id, String, tag: 'id'
  attribute :xmlns, String, tag: 'xmlns'
  element :status, Status, tag: 'status'
  element :title, String, tag: 'title'
  element :description, String, tag: 'description'
  element :notice, Notice, tag: 'notice'
  element :reference, ReferenceBenchmark, tag: 'reference'
  element :plaintext, Plaintext, tag: 'plain-text'
  element :version, String, tag: 'version'
  has_many :profile, Profile, tag: 'Profile'
  has_many :group, Group, tag: 'Group'


  # def where(attrib, data)
  #   stig.istig.vuln.each do |vuln|
  #     if vuln.stig_data.any? { |element| element.attrib == attrib && element.data == data}
  #       # @todo Handle multiple objects that match the condition
  #       return vuln
  #     end
  #   end
  # end
end
cklist = '/Users/rxman/Documents/MITRE/INSPEC/inspec2xccdf/data/post.xml'
benchmark = Benchmark.new
doc = File.open(cklist) { |f| Nokogiri::XML(f) }
# benchmark = Benchmark.parse(doc.to_s)

# benchmark.id = "PostgreSQL_9-x_STIG"
# benchmark.xmlns = "http://checklists.nist.gov/xccdf/1.1"
# benchmark.status = 'accepted'
# benchmark.date = '2017-01-20'
# puts benchmark.to_xml
File.write('output_xccdf.xml', benchmark.to_xml)
