require 'csv'
require 'time'

class DataStore

  DEFAULT_PATH = File.expand_path('../store.dat', File.dirname(__FILE__)).freeze

  def initialize(filepath = DEFAULT_PATH)
    @filepath = filepath
  end

  def save(service_status)
    CSV.open(@filepath, 'a', col_sep: ';') do |csv|
      csv << service_status.to_a
    end
  end

  def load_each(&block)
    return unless File.exist?(@filepath)

    CSV.foreach(@filepath, col_sep: ';',  headers: false) do |row|
      loaded_status = ServiceStatus.new(row[0], row[1], Time.parse(row[2]))
      block[loaded_status]
    end
  end

end
