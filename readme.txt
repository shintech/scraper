Tested on Xubuntu 15.10
Ruby 2.3.0
Requires Ruby Gems listed below:
  "zip"
  "nokogiri"
  "open-uri"
  "redis"

Downloads files linked to in <a> tags on url specified in app.target and imports contents of zip files to Redis list specified in app.redis_list.

Target url and Redis list can be changed as per instructions below.

Directions:

Open terminal in the root directory and type "ruby lib/run.rb"

**Must be executed from root directory or error logging will not work correctly.

################################################

app.target("http://example.org/whatever")    # url from which to download zip files
app.redis_list("NEWS_XML")    # name of Redis list.
app.start     # downloads and extracts contents of zip folders to redis_list
