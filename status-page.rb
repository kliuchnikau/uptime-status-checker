#!/usr/bin/env ruby

require_relative "lib/lib"

puts StatusSource::Github.new().current_status
puts StatusSource::Bitbucket.new().current_status
puts StatusSource::Rubygems.new().current_status
puts StatusSource::Cloudflare.new().current_status
