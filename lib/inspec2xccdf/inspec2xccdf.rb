#!/usr/local/bin/ruby
# encoding: utf-8
# author: Aaron Lippold
# author: Rony Xavier rx294@nyu.edu

require 'happymapper'
require 'nokogiri'
require 'json'
require_relative 'benchmark'

class Inspec2ckl < Benchmark
  # def initialize(json, cklist, output, verbose)
  def initialize()
    # @verbose = verbose
    # inspec_json = File.read(json)
    # @data = parse_json(inspec_json)
    # doc = File.open(cklist) { |f| Nokogiri::XML(f) }
    @benchmark = Benchmark.new
    # @checklist = Checklist.parse(doc.to_s)
    populate_xml
    # update_ckl_file
    File.write('test_xccdf.xml', @benchmark.to_xml)
    # puts "\nProcessed #{@data.keys.count} controls"
  end

  def populate_xml
    group = Group.new
    group.id = 'V-72841'
    group.title = 'SRG-APP-000142-DB-000094'
    group.description = '<GroupDescription></GroupDescription>'
    rule = Rule.new
    rule.id = 'SV-87493r1_rule'
    rule.severity = 'medium'
    rule.weight = '10.0'
    rule.version = 'PGS9-00-000100'
    rule.title = 'PostgreSQL must be configured to prohibit or restrict the use of organization-defined functions, ports, protocols, and/or services, as defined in the PPSM CAL and vulnerability assessments.'
    description = Description.new
    description.vulndiscussion = 'In order to prevent unauthorized connection'
    # description.documentable = 'false'
    rule.description = '<VulnDiscussion>In order to prevent unauthorized connection</VulnDiscussion>'
    # rule.description = description
    reference = ReferenceGroup.new
    reference.dc_title = 'DPMS Target PostgreSQL 9.x'
    reference.dc_publisher = 'DISA'
    reference.dc_type = 'DPMS Target'
    reference.dc_subject = 'PostgreSQL 9.x'
    reference.dc_identifier = '3087'
    rule.reference = reference
    ident = Ident.new
    ident.system = 'http://iase.disa.mil/cci'
    ident.ident = 'CCI-000382'
    rule.ident = ident
    fixtext = Fixtext.new
    fixtext.fixref = 'F-79283r1_fix'
    fixtext.fixtext = 'Note: The following instructions use the PGDATA environment variable. See supplementary content APPENDIX-F for instructions on configuring PGDATA.'
    rule.fixtext = fixtext
    fix = Fix.new
    fix.id = 'F-79283r1_fix'
    rule.fix = fix
    check = Check.new
    check.system = 'C-72975r1_chk'
    content_ref = ContentRef.new
    content_ref.name = 'M'
    content_ref.href = 'DPMS_XCCDF_Benchmark_PostgreSQL_9-x_STIG.xml'
    check.content_ref = content_ref
    check.content = 'As the database administrator, run the following SQL:'
    rule.check = check
    group.rule = rule
    plaintext = Plaintext.new
    plaintext.id = 'release-info'
    plaintext.plaintext = 'Release: 1 Benchmark Date: 20 Jan 2017'
    @benchmark.plaintext = plaintext
    @benchmark.title = 'PostgreSQL 9.x Security Technical Implementation Guide'
    @benchmark.description = 'This Security Technical Implementation Guide is published as a tool to improve the security of Department of Defense (DoD) information systems. The requirements are derived from the National Institute of Standards and Technology (NIST) 800-53 and related documents. Comments or proposed revisions to this document should be sent via email to the following address: disa.stig_spt@mail.mil.'
    @benchmark.group = group
  end
  #
  # def clk_status(control)
  #   puts 'Full Status list: ' + control[:status].join(', ') if @verbose
  #   status_list = control[:status].uniq
  #   if status_list.include?('failed')
  #     result = 'Open'
  #   elsif status_list.include?('passed')
  #     result = 'NotAFinding'
  #   elsif status_list.include?('skipped')
  #     result = 'Not_Reviewed'
  #   else
  #     result = 'Not_Tested'
  #   end
  #   if control[:impact].to_f.zero?
  #     result = 'Not_Applicable'
  #   end
  #   result
  # end
  #
  # def clk_finding_details(control)
  #   control_clk_status = @checklist.where('Vuln_Num',control[:control_id]).status
  #   result = "One or more of the automated tests failed or was inconclusive for the control \n\n #{control[:message].sort.join}" if control_clk_status == 'Open'
  #   result = "All Automated tests passed for the control \n\n #{control[:message].join}" if control_clk_status == 'NotAFinding'
  #   result = "Automated test skipped due to known accepted condition in the control : \n\n#{control[:message].join}" if control_clk_status == 'Not_Reviewed'
  #   result = "Justification: \n #{control[:message].split.join(' ')}" if control_clk_status == 'Not_Applicable'
  #   result = 'No test available for this control' if control_clk_status == 'Not_Tested'
  #   result
  # end
  #
  # def update_ckl_file
  #   @data.keys.each do | control_id |
  #     print '.'
  #     vuln = @checklist.where('Vuln_Num',control_id.to_s)
  #     vuln.status = clk_status(@data[control_id])
  #     vuln.comments << "\n#{Time.now}: Automated compliance tests brought to you by the MITRE corporation, CrunchyDB and the InSpec project."
  #     vuln.finding_details << clk_finding_details(@data[control_id])
  #
  #     if @verbose
  #       puts control_id
  #       puts @checklist.where('Vuln_Num',control_id.to_s).status
  #       puts @checklist.where('Vuln_Num',control_id.to_s).finding_details
  #       puts '====================================='
  #     end
  #   end
  # end
  #
  # def parse_json(json)
  #   file = JSON.parse(json)
  #   controls = file['profiles'].last['controls']
  #   data = {}
  #   controls.each do |control|
  #     c_id = control['id'].to_sym
  #     data[c_id] = {}
  #     data[c_id][:control_id] = control['id']
  #     data[c_id][:impact] = control['impact'].to_s
  #     data[c_id][:status] = []
  #     data[c_id][:message] = []
  #     if control.key?('results')
  #       control['results'].each do |result|
  #         data[c_id][:status].push(result['status'])
  #         data[c_id][:message].push(result['skip_message']) if result['status'] == 'skipped'
  #         data[c_id][:message].push("FAILED -- Test: #{result['code_desc']}\nMessage: #{result['message']}\n") if result['status'] == 'failed'
  #         data[c_id][:message].push("PASS -- #{result['code_desc']}\n") if result['status'] == 'passed'
  #       end
  #     end
  #     if data[c_id][:impact].to_f.zero?
  #       data[c_id][:message] = control['desc']
  #     end
  #   end
  #   data
  # end
end
Inspec2ckl.new
