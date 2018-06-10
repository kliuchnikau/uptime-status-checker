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

  desc "live", "Constantly query the URLs and output the status \
                periodically on the console and save it to the data store."
  def live
  end

  desc "history", "Display all the data which was gathered by the tool."
  def history
  end

  desc "backup PATH", "Takes a path variable, and creates a backup \
                       of historic and currently saved data."
  def backup(path)
  end

  desc "restore PATH", "Takes a path variable which is a backup \
                        created by the application and restores that data."
  def restore(path)
  end

end

StatusPageCLI.start(ARGV)
