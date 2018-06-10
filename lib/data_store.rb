class DataStore

  def initialize(filepath = default_data_store_path)
    @filepath = filepath
  end

  def save(service_status)
  end

  def load_each()
  end

  private

  def default_data_store_path
    File.expand_path('store.dat', File.dirname(__FILE__))
  end

end
