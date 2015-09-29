#!/usr/bin/env ruby
count = gets.to_i

count.step(1, -1) do |star_count|
  puts (" " * (count - star_count) + "*" * star_count)
end
