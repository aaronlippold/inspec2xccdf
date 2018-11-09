# inspec2xccdf
Inspec2xccdf convertes an Inspec profile into STIG XCCDF Document

## Versioning and State of Development
This project uses the [Semantic Versioning Policy](https://semver.org/). 

### Branches
The master branch contains the latest version of the software leading up to a new release. 

Other branches contain feature-specific updates. 

### Tags
Tags indicate official releases of the project.

Please note 0.x releases are works in progress (WIP) and may change at any time.   

## Usage
./inspec2xccdf exec -j example.json -a attributes.yml -t application_name

	-j --inspec_json  : Path to inspec Json file created using command 'inspec json <profile> > example.json'
	-a --attributes   : Path to yml file that provides the required attributes for the XCCDF Document. 
    				   Sample file can be generated using command'inspec2xccdf generate_attribute_file'
     -t --xccdf_title : XCCDF title

## Generate sample attribute file 
./inspec2xccdf generate_attribute_file 

## Attributes
    benchmark.title : 'Application 5.x Security Technical Implementation Guide'
    benchmark.id : "Application_5-x_STIG" 
    
    benchmark.description : 'This Security Technical Implementation Guide is published as a tool to improve the security of Department of Defense (DoD) information systems. The requirements are derived from the National Institute of Standards and Technology (NIST) 800-53 and related documents. Comments or proposed revisions to this document should be sent via email to the following address: disa.stig_spt@mail.mil.'
    
    benchmark.version : '1'
    benchmark.status : accepted
    benchmark.status.date : "2017-09-27"
    benchmark.notice : ""
    benchmark.notice.id : "terms-of-use" 
    benchmark.plaintext : "Release 1 Benchmark Date 27 Sep 2017"
    benchmark.plaintext.id : 'release-info'

    reference.href : "http://iase.disa.mil"
    reference.dc.source : STIG.DOD.MIL
    reference.dc.publisher : DISA
    reference.dc.title : 'DPMS Target Application 5.x'
    reference.dc.subject : 'Application 5.x'
    reference.dc.type : 'DPMS Target'
    reference.dc.identifier : '3087'

    content_ref.href : 'DPMS_XCCDF_Benchmark_Application_5-x_STIG.xml'
    content_ref.name : 'M'
    
## NOTICE

© 2018 The MITRE Corporation.  

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.  

## NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation. 

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.  
