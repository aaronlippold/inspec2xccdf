# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inspec2xccdf/version'

Gem::Specification.new do |spec|
  spec.name          = 'inspec2xccdf'
  spec.version       = Inspec2xccdf::VERSION
  spec.authors       = ['Aaron Lippold']
  spec.email         = ['lippold@gmail.com']
  spec.authors       = ['Rony Xaiver']
  spec.email         = ['rx294@gmail.com']
  spec.summary       = 'Infrastructure and compliance testing parser and converter'
  spec.description   = 'Inspec2xccdf convertes an Inspec profile into STIG XCCDF Document'
  spec.homepage      = 'https://github.com/aaronlippold/inspec2xccdf'
  spec.license       = 'Apache-2.0'

  spec.files = %w{
    README.md LICENSE inspec2xccdf.gemspec
    Gemfile .rubocop.yml
  } + Dir.glob(
    '{bin,data,lib}/**/*', File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }

  spec.executables   = %w{ inspec2xccdf }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency 'nokogiri-happymapper', '~> 0'
  spec.add_dependency 'happymapper', '~> 0'
  spec.add_dependency 'nokogiri', '~> 1.8.1'
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'json', '>= 1.8', '< 3.0'
  spec.add_dependency 'pry', '~> 0'
  spec.add_dependency 'yaml', '~> 0'
end
