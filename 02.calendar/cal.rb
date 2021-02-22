#!/usr/bin/env ruby

require 'optparse'
require 'date'

def print_header(year = 0, month = 0)
  puts "      #{month}月 #{year}\n日 月 火 水 木 金 土"
end

def weeks(year, month)
  weeks = []
  i = 0
  [*1..Date.new(year, month, -1).day].each do |day|
    date = Date.new(year, month, day)
    wday = date.wday
    if day == 1
      weeks[i] = Array.new(7, '  ')
    elsif wday == 0
      i += 1
      weeks[i] = Array.new(7, '  ')
    end
    str_day = day.to_s
    if day < 10
      str_day = " " + str_day
    end
    if date == Date.today
      str_day = "\e[7m#{str_day}\e[0m"
    end
    weeks[i][wday] = str_day
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

options = ARGV.getopts('y:m:')

year  = options['y'].to_i
year  = Date.today.year if year == 0

month = options['m'].to_i
month = Date.today.month if month == 0 || month < 1 || month > 12

print_header(year, month)
print_body(year, month)
