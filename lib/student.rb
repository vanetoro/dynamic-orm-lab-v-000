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

  attr_accessor :id, :name, :grade

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def self.table_name
      self.to_s.downcase.pluralize
  end

  def self.column_names
     ATTRIBUTES.keys.map do |a|
      a.to_s
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    binding.pry
    self.class.column_names.delete_if {|col| col = 'id'}.join(" ,")
  end


end
