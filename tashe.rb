require_relative 'lib/tashe.rb'
input = File.read(ARGV[0])
puts Conference.new(input).to_output_format
