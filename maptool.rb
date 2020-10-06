#!/usr/bin/env ruby

require 'maptool'
require 'optparse'

args = Hash.new

OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  opts.on("-rROWS", "--rows=ROWS", "Dungeon rows (default: 10)") do |r|
    args[:rows] = r.to_i
  end

  opts.on("-cCOLS", "--cols=COLS", "Dungeon cols (default: 10)") do |c|
    args[:cols] = c.to_i
  end

  opts.on("-ePROBABILTY", "--empty=PROBABILTY", "Probablility of creating an empty tile (default: 0.02)") do |e|
    args[:prob] = e.to_f
  end

  opts.on("-pPRECISION", "--precision=PRECISION", "Precision used for calculationg weighted probablities with -e (default: 2, will resort to defaults if <2 || > 14)") do |p|
    args[:prec] = p.to_i
  end

  opts.on("-b", "--border", "Print tile border (default: false)") do |b|
    args[:border] = b
  end

  opts.on("-v", "--verbose", "Verbose mode") do |v|
    args[:verbose] = v
  end

  opts.on("-V", "--superverbose", "Super verbose mode") do |vv|
    args[:superverbose] = vv
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

cols = (args[:cols] || 10)
rows = (args[:rows] || 10)
empty_weight = (args[:prob] || 0.02)
precision = (args[:prec] || 2)
precision = 14 if precision > 14
precision = 2 if precision < 2

mt = Maptool.new(cols, rows, empty_weight, precision, args[:border], args[:verbose], args[:superverbose])
mt.run!
mt.print_map
