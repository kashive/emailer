require 'json'
def nested_hash_value(obj,key)
  if obj.respond_to?(:key?) && obj.key?(key)
    obj[key]
  elsif obj.respond_to?(:each)
    r = nil
    obj.find{ |*a| r=nested_hash_value(a.last,key) }
    r
  end
end

file = File.open("clubLeaders.txt", "rb")
contents = file.read
file.close
hashData = JSON.parse(contents)
puts nested_hash_value(hashData,"Brandeis Academic Debate and Speech Society")

