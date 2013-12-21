require 'json'
file = File.open("clubLeaders.txt", "rb")
contents = file.read
file.close
hashData = JSON.parse(contents)
