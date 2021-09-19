require_relative 'meta'
require 'find'

def usage
  puts <<~EOS
    Usage: 
      ruby meta_json.rb PATH_LIST
      ruby meta_json.rb -d DIR
  EOS
end

if ARGV.empty?
  usage
  exit
end

if ARGV.size == 2 && ARGV[0] == '-d'
  dir = ARGV[1]
  metas = [] 
  Find.find(dir) do |path|
    metas << Meta.from_path(path)
  end
else
  paths = IO.readlines ARGV.shift
  metas = paths.map do |path|
    path.chomp!
    Meta.from_path(path)
  end
end

metas.sort_by!(&:size)
metas.reverse!

puts "["
puts (metas.map do |meta|
  %(  { "path": "#{meta.path}", "mtime": "#{meta.mtime}", "size": #{meta.size} })
end.join(",\n"))
puts "]"
