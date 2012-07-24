#!/usr/bin/env ruby

# The guess number game
pick = rand(10)
guess = -1
while guess != pick
	puts "Enter choice:"
	gets
	guess = $_.to_i
	puts "Too low" if guess < pick
	puts "Too high" if guess > pick
end
puts "You win!"
