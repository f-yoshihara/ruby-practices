#!/usr/bin/env ruby

require 'optparse'
require 'date'

# カレンダーのヘッダーを出力する
def puts_header(year = 0, month = 0)
  puts "      #{month}月 #{year}\n日 月 火 水 木 金 土"
end

# カレンダーの週を配列で取得する
def get_weeks(year, month)
  weeks = []
  i = 0
  [*1..Date.new(year, month, -1).day].each do |day|
    date = Date.new(year, month, day)
    wday = date.wday
    is_start_of_week = wday == 0
    is_start_of_month = day == 1
    if is_start_of_week && ! is_start_of_month
      i += 1
    end
    if is_start_of_week || is_start_of_month
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

# カレンダーのボディの各行の内容を取得する
def get_body_lines(year, month)
  get_weeks(year, month).map do |week|
    week.join(' ')
  end
end

# カレンダーのボディを出力する
def puts_body(year, month)
  get_body_lines(year, month).each do |line|
    puts line
  end
end

options = ARGV.getopts('y:m:')

year  = options['y'].to_i
year  = Date.today.year if year == 0

month = options['m'].to_i
month = Date.today.month if month == 0 || month < 1 || month > 12

puts_header(year, month)
puts_body(year, month)
