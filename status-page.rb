#!/usr/bin/env ruby

require 'thor'
require_relative "lib/lib"

class StatusPageCLI < Thor

  ALL_NET_HTTP_ERRORS = [
    Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
    Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError,
    SocketError, StatusSource::RemoteError
  ]

  desc "pull", "Pull all the status page data from different \
                providers and save into the data store."
  def pull
    data_store = DataStore.new
    [
      StatusSource::Github,
      StatusSource::Bitbucket,
      StatusSource::Rubygems,
      StatusSource::Cloudflare
    ].each do |status_source|
      begin
        status = status_source.new().current_status
        data_store.save(status)
        puts status
      rescue *ALL_NET_HTTP_ERRORS
        # We do not want to fail all requests because one of them is down/misconfigured
        puts "Error: Cannot read status"
      end
    end
  end

  desc "live", "Constantly (every 10 seconds) query the URLs and output the status \
                periodically on the console and save it to the data store.
                Interrupt the process to stop (Ctrl+C)."
  def live
    loop do
      pull

      # Sleeping for 10 seconds to avoid throttling from service providers
      # If we make requests to often we might get blocked
      sleep 10
    end
  end

  desc "history", "Display all the data which was gathered by the tool."
  def history
    DataStore.new.load_each do |status|
      puts status
    end
  end

  desc "backup PATH", "Takes a path variable, and creates a backup \
                       of historic and currently saved data."
  def backup(path)
    if File.exist?(path)
      puts "File with this path already exists. Please choose another path."
      return
    end

    # recursively create a directory for the file
    dirname = File.dirname(path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end

    Backup.new.store(path)
  end

  desc "restore PATH", "Takes a path variable which is a backup \
                        created by the application and restores that data."
  def restore(path)
    unless File.exist?(path)
      puts "Backup file with this path does not exists. Please specify the correct path."
      return
    end

    Backup.new.restore(path)
  end

end

StatusPageCLI.start(ARGV)
