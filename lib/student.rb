require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'
require 'pry'

class Student < InteractiveRecord

ATTRIBUTES = {
  :id => 'PRIMARY KEY INTEGER',
  :name => 'TEXT',
  :grade => 'TEXT'
}

 attr_accessor  :name, :grade, :id


  def initialize(options={})
    options.each do | key, value|
      self.send("#{key}=", value)
    end
  end


  def self.table_name
    self.to_s.downcase.pluralize
  end

  def table_name_for_insert
    self.class.table_name
  end

  def self.column_names
   ATTRIBUTES.keys.map {|key| key.to_s}
  end

  def col_names_for_insert
    self.class.column_names.delete_if { |col| col == "id"  }.join(', ')
  end

  def values_for_insert
    values = []
    col_names_for_insert.split(', ').each do | col|
        values << "'#{self.send(col)}'"
      end
      values.join(', ')
  end

  def save
    sql = "INSERT INTO #{table_name_for_insert} (#{self.col_names_for_insert}) VALUES (#{self.values_for_insert})"

    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM #{self.table_name} WHERE name = '#{name}'"
    DB[:conn].execute(sql)
  end

  def self.find_by(attribute)
    sql = "SELECT * FROM #{self.table_name} WHERE #{attribute.keys[0].to_s} = '#{attribute.values[0].to_s}'"
    DB[:conn].execute(sql)
  end



end
