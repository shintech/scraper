require "zip"
require 'nokogiri'
require 'open-uri'
require 'redis'

class Scraper

  attr_accessor :target, :redis_list
  attr_reader :number_of_errors, :urls

  def initialize
    @r = Redis.new
    @target = target
    @redis_list = redis_list
    @number_of_errors = []
    @urls = []
  end

  def start
    retries = 2
    get_urls(@target)
    puts "Downloading files from #{@target}..."
    @urls.each do |url|
      begin
      xml_to_redis("#{target}#{url}")
      rescue => error
        if retries == 0
          puts "Error, skipped after three failed attempts..."
          report_error("##Skipped #{url} at #{DateTime.now}\n#{error.class}: #{error.message}")
          retries = 2
          @number_of_errors << "#{url}"
          next
        else
          puts "Error, retrying..."
          retries -= 1
          retry
        end
      end
    end
  end

  def get_urls(target)
    page = Nokogiri::HTML(open(target))
    page.xpath('//a/@href').each do |links|
      @urls << links.content
    end
  end
  
  def xml_to_redis(url)
    if url.split(".").last == "zip"
      download = open(url)
      Zip::File.open(download) do |zip_file|
        zip_file.each do |f|
          xmldoc = f.get_input_stream.read
          @r.sadd "#{@redis_list}", "#{xmldoc}"
        end
        puts "Finished processing #{url}..."
        download.close
      end
    end
  end

  def report_error(error_message)
    File.open('log.txt', 'a') do |file|
      file.puts error_message
    end
  end

end
