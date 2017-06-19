# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "satoshiproc-unit"
  gem.homepage = "http://github.com/oscarguindzberg/satoshiproc-unit"
  gem.license = "MIT"
  gem.summary = %Q{Converts various proc denominations in Satoshis and back}
  gem.description = %Q{Converts various proc denominations in Satoshis and back}
  gem.email = "oscar.guindzberg@gmail.com"
  gem.authors = ["Roman Snitko", "Oscar Guindzberg"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
