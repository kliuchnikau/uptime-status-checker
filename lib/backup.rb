class Backup

  def initialize(datastore_path = DataStore::DEFAULT_PATH)
    @datastore_path = datastore_path
  end

  def store(path)
    return unless File.exist?(@datastore_path)

    FileUtils.copy_file(@datastore_path, path)
  end

  def restore(path)
    remove_current_datastore

    FileUtils.copy_file(path, @datastore_path)
  end

  private

  def remove_current_datastore
    File.delete(@datastore_path) if File.exist?(@datastore_path)
  end

end
