require 'json'
require_relative './meta'

array = JSON.parse(File.read(ARGV.shift))
metas = array.map do |d|
  Meta.new(d['path'], d['mtime'], d['size'])
end

def num_with_delimiter(n)
  n.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse!
end

def gb(n)
  n.to_f / (1024 * 1024 * 1024)
end

total_size = metas.sum { |m| m.size }
total_storage_size = metas.sum { |m| m.storage_size }
puts "# of files  : #{metas.size}"
puts "total size  : #{num_with_delimiter(total_size)} (#{'%.1f' % gb(total_size)}GiB)"
puts "storage size: #{num_with_delimiter(total_storage_size)} (#{'%.1f' % gb(total_storage_size)}GiB)"
