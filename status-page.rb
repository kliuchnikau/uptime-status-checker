#!/usr/bin/env ruby

require 'thor'
require_relative "lib/lib"

class StatusPageCLI < Thor

  desc "pull", "Pull all the status page data from different \
                providers and save into the data store."
  def pull
    puts StatusSource::Github.new().current_status
    puts StatusSource::Bitbucket.new().current_status
    puts StatusSource::Rubygems.new().current_status
    puts StatusSource::Cloudflare.new().current_status
  end

end

StatusPageCLI.start(ARGV)
