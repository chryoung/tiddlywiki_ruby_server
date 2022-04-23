#!/usr/bin/env ruby
# Install webrick
# gem install webrick
# Then run this script

require 'webrick'
require 'fileutils'
require 'optparse'

options = {
  address: "127.0.0.1",
  port: 5000,
  root: ".",
  wiki_file: "index.html",
  backup: "bak",
  max_backup: 5,
}

OptionParser.new do |opts|
  opts.banner = "Usage server.rb [options]"

  opts.on("-h", "--help", "Print this help") do
    puts opts
    exit
  end

  opts.on("-bADDRESS", "--bind=ADDRESS", "Bind to the address. [Default: #{options[:address]}]") do |addr|
    options[:address] = addr
  end

  opts.on("-pPORT", "--port=PORT", "Bind to the port. [Default: #{options[:port]}]") do |port|
    options[:port] = port
  end

  opts.on("-uBACKUP", "--backup=BACKUP", "Backup folder. [Default: #{options[:backup]}]") do |bak|
    options[:backup] = bak
  end

  opts.on("-fWIKI_FILE", "--file=WIKI_FILE", "The tiddlywiki file to serve and save. [Default: #{options[:wiki_file]}]") do |f|
    options[:wiki_file] = f
  end

  opts.on("-rROOT", "--root=ROOT", "The root of the tiddlywiki server. [Default: #{options[:root]}]") do |r|
    options[:root] = r
  end

  opts.on("-mMAX_BACKUP", "--max-backup=MAX_BACKUP", "The max number of backup files. [Default: #{options[:max_backup]}]") do |m|
    options[:max_backup]
  end
end.parse!

WIKI_FILE = options[:wiki_file]
BACKUP = options[:backup]
MAX_BACKUP = options[:max_backup]

module WEBrick
   module HTTPServlet

      class FileHandler
         alias do_PUT do_GET
      end

      class DefaultFileHandler
         def do_PUT(req, res)
            res.body = ''

            FileUtils.cp(WIKI_FILE, "#{BACKUP}/#{WIKI_FILE}.#{Time.now.to_i.to_s}.html")
            File.open(WIKI_FILE, "w+") do |f|
              f.puts(req.body)
            end

            # Remain only last 5 backup
            Dir.glob("#{BACKUP}/*.html").sort.reverse.drop(MAX_BACKUP).each do |backup|
              File.unlink backup
            end
         end

         def do_OPTIONS(req, res)
            res['allow'] = "GET,HEAD,POST,OPTIONS,CONNECT,PUT,DAV,dav"
            res['x-api-access-type'] = 'file'
            res['dav'] = 'tw5/put'
         end

      end
   end
end

server = WEBrick::HTTPServer.new Port: options[:port], DocumentRoot: options[:root], BindAddress: options[:address]

trap "INT" do
   puts "Shutting down..."
   server.shutdown
end

unless Dir.exists? options[:backup]
   Dir.mkdir options[:backup]
end

server.start
