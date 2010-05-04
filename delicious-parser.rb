#!/usr/local/bin/ruby -w
require 'rexml/document'

lisp_dir = "/home/toshi/.emacs.d"

file  =  File.new("#{lisp_dir}/delicious_raw_data.xml" , "r")
doc  =  REXML::Document.new file

list_file = File.open("#{lisp_dir}/delicious.list", "w")
el_file  =  File.open("#{lisp_dir}/delicious.list.el", "w")

el_file.puts "(setq anything-delicious-bookmarks-data '("

doc.elements.each('posts/post') do |post|
  list_file.puts "#{post.attributes["description"]}/#{post.attributes['tag']}"

  el_file.print "("
  el_file.print "\"#{post.attributes["description"]}/#{post.attributes['tag']}\""
  el_file.print " . "
  el_file.print "\"#{post.attributes["href"]}\""
  el_file.puts ")"

end

el_file.print "))"
list_file.close
el_file.close
