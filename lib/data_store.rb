require 'csv'

class DataStore

  def initialize(filepath = default_data_store_path)
    @filepath = filepath
  end

  def save(service_status)
    CSV.open(@filepath, 'a', col_sep: ';') do |csv|
      csv << service_status.to_a
    end
  end

  def load_each()
  end

  private

  def default_data_store_path
    File.expand_path('store.dat', File.dirname(__FILE__))
  end

end
