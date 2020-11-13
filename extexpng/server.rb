#!/usr/bin/env ruby
# coding: utf-8

require "webrick"
require "webrick/https"
require "yaml"

conf = nil
if ARGV.size == 1 && ARGV[0] == "heroku"
    conf = YAML.load(open("config_heroku.yaml").read)
else
    conf = YAML.load(open("config.yaml").read)
end

sslp = OpenSSL::PKey::RSA.new(open(conf["privkey"]).read) if File.exist? conf["certkey"].to_s
sslc = OpenSSL::X509::Certificate.new(open(conf["certkey"]).read) if File.exist? conf["certkey"].to_s

srv = WEBrick::HTTPServer.new({
    :DocumentRoot => "./",
    :Port => "31415",
    :BindAddress => "0.0.0.0",
    :DocumentRootOptions => {
        :FancyIndexing => false
    },
    :ServerSoftware => "WEBrick",
    # :SSLEnable => (!!sslp && !!sslc),
    # :SSLCertificate => sslc,
    # :SSLPrivateKey => sslp
})

srv.mount("/tex.png", WEBrick::HTTPServlet::CGIHandler, "tex.rb")
srv.config[:MimeTypes]["erb"] = "text/html"

trap("INT"){
    srv.shutdown
}
srv.start