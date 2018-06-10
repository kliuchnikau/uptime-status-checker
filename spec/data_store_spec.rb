describe DataStore do

  let(:datastore_file) do
    File.expand_path('../fixtures/datastore.dat', File.dirname(__FILE__))
  end

  let(:datastore_content) { File.read(datastore_file) }

  after do
    File.delete(datastore_file) if File.exist?(datastore_file)
  end

  subject { described_class.new(datastore_file) }

  describe "#save" do

    it "stores service status as a CSV line" do
      Timecop.freeze(Time.local(2018, 1, 1, 0, 0, 0))

      status = ServiceStatus.new('Github', 'good')
      subject.save(status)

      expect(datastore_content).to eq(
        "Github;good;2018-1-1:00:00:00"
      )
    end

    context "when file exists but does not have proper permissions"

  end

  describe "#load_each" do

  end

end
