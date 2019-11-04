# encoding: UTF-8

require 'yaml'
require 'Date'
require 'json'
require 'fileutils'

APPFOLDER = File.expand_path(File.dirname(File.dirname(__FILE__)))
puts APPFOLDER

# Requérir tous les modules du dossier "required/first", puis "then"
puts "# Chargement de #{APPFOLDER}/lib/required/first/*.rb"
Dir["#{APPFOLDER}/lib/required/first/**/*.rb"].each{|m| require m}
puts "# Chargement de #{APPFOLDER}/lib/required/then/*.rb"
Dir["#{APPFOLDER}/lib/required/then/**/*.rb"].each{|m| require m}
