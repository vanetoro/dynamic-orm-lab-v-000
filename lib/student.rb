require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'
require 'pry'

class Student < InteractiveRecord

  ATTRIBUTES = {
    :id => 'INTEGER PRIMARY KEY',
    :name => 'TEXT',
    :grade => 'TEXT'
  }

  def initialize

  end

  def self.table_name
      self.to_s.downcase.pluralize
  end

  def self.column_names
     ATTRIBUTES.keys.map do |a|
      a.to_s
    end
  end

end
