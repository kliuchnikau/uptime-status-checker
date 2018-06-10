#!/usr/bin/env ruby

require_relative "lib/lib"

puts StatusSource::Github.new().current_status
