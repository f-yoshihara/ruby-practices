#!/usr/bin/env ruby

require 'date'

def print_header(year=0, month=0)
  puts "      #{month}月 #{year}\n日 月 火 水 木 金 土"
end

def weeks(year, month)
  weeks = []
  i = 0
  [*1..Date.new(year, month, -1).day].each do |day|
    wday = Date.new(year, month, day).wday
    if day == 1
      weeks[i] = Array.new(7, '  ')
    elsif wday == 0
      i += 1
      weeks[i] = Array.new(7, '  ')
    end
    weeks[i][wday] = day < 10 ? " " + day.to_s : day.to_s
  end
  weeks
end

def lines(year, month)
  weeks(year, month).map do |week|
    week.join(' ')
  end
end

def print_body(year, month)
  lines(year, month).each do |line|
    puts line
  end
end

year = 2021
month = 2

print_header(year, month)
print_body(year, month)