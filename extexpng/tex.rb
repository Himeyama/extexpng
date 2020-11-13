#!/usr/bin/env ruby
# coding: utf-8

require "cgi"
require "fileutils"
require "base64"
require "digest/md5"
require "yaml"

conf = YAML.load(open("config.yaml").read)
cgi = CGI.new
text = Base64.decode64(cgi.params["text"][0])
md5 = Digest::MD5.hexdigest(text)

puts cgi.header({"type" => "image/png"})

if conf["keyword"] == cgi.params["keyword"][0]
    ENV["PATH"] = "/usr/bin"
    unless File.exist? "cache/#{md5}.png"
        open "temp.tex", "w" do |f|
            f.write text
        end
        status = system("latex temp.tex >/dev/null 2>&1")
        status = system("dvipdfmx temp.dvi >/dev/null 2>&1") if status
        status = system("pdfcrop temp.pdf >/dev/null 2>&1") if status
        status = system("pdftocairo -png -r 600 temp-crop.pdf >/dev/null 2>&1") if status
        FileUtils.mv "temp-crop-1.png", "cache/#{md5}.png" if File.exist? "temp-crop-1.png" if status
        FileUtils.rm_f(["temp.dvi", "temp.aux", "temp.log", "temp.tex", "temp.pdf", "temp-crop.pdf"])
    end
    print open("cache/#{md5}.png", "rb").read if File.exist? "cache/#{md5}.png"
end