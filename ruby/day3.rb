#!/usr/bin/env ruby

module ActAsCsv
	def self.included(base)
		base.extend ClassMethods
	end
	module ClassMethods
		def acts_as_csv
			include InstanceMethods
		end
	end
	module InstanceMethods
		def read
			@csv_contents = []
			filename = self.class.to_s.downcase + '.txt'
			file = File.new(filename)
			@headers = file.gets.chomp.split(', ')
			file.each do |row|
				@csv_contents << row.chomp.split(', ')
			end
		end

		def each
			csv_contents.each do |content|
				row = CsvRow.new(headers, content)
				yield(row);
			end
		end

		attr_accessor :headers, :csv_contents
		def initialize
			read
		end
	end
end

class CsvRow
	def method_missing name, *args
		row[name.to_s]
	end
	attr_accessor :row
	def initialize(headers, content)
		@row = Hash.new
		headers.each_index {|i| @row[headers[i]] = content[i]  }
	end
end

class RubyCsv
	include ActAsCsv
	acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
puts
m.each {|row| puts row.last}
