#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-
#
#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                  Version 2, December 2004
#
#  Copyright (C) 2004 Sam Hocevar
#  14 rue de Plaisance, 75014 Paris, France
#  Everyone is permitted to copy and distribute verbatim or modified
#  copies of this license document, and changing it is allowed as long
#  as the name is changed.
#  DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#
#
#  David Hagege <david.hagege@gmail.com>
#

require 'zip'
require 'fileutils'

abort "Usage #{__FILE__} DPI DESTINATION.zip" if ARGV.size != 2

dpi = ARGV[0]

if File.exists?(ARGV[1])
  STDOUT.print "#{ARGV[1]} already exists. Overwrite? [Y/n]: "
  ['Y', "\n"].include?(STDIN.getc) ? FileUtils.rm(ARGV[1]) : abort
end

Zip::File.open(ARGV[1], Zip::File::CREATE) do |zipfile|
  Dir[File.join('META-INF/', '**', '**')].each do |file|
    zipfile.add(file.sub('', ''), file)
    if file =~ /.*\/update-binary\Z/
      data = File.read(file)
      data.gsub!(/NEW_DPI/, dpi)
      zipfile.get_output_stream(file) { |f| f.write data }
    end
  end
end
