require_relative 'app'
require 'io/console'

app = Scraper.new
app.target = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
app.redis_list = "NEWS_XML"
app.start

puts "All done!!"
puts "There were #{app.number_of_errors.length} errors, check log.txt for details..."
puts "Press any key to exit..."
STDIN.getch
