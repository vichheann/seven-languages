#!/usr/bin/env ruby

puts "== Find out how to access files with and without code blocks =="

fileName = "I_have_a_dream.txt"

IO.foreach(fileName) { |line| puts line }

file = File.open(fileName, "r")
while file.gets
  puts $_
end
file.close
puts

puts "== Translate a hash to an array =="
numbers = {:one => 'un', :two => 'deux' , :three => 'trois'}
puts numbers.to_a

puts "== Print the contents of any array of 16 numbers, 4 numbers at a time =="
puts "= with each ="
numbers = []
0.upto(15) {|i| numbers[i] = i }

slice = []
count = 0
numbers.each do |i|
  count = count + 1
  slice.push(i)
  if count == 4
    p slice
    slice = []
    count = 0
  end
end
puts "= with each_slice ="
numbers.each_slice(4) {|s| p s}
puts

puts "== Write a grep =="
def grep(search, fileName)
	count = 0
	IO.foreach(fileName) do |line|
		count = count + 1
		puts "#{count}: #{line}" if line =~ /#{search}/
	end
end

grep("freedom", 'I_have_a_dream.txt')
