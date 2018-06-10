describe DataStore do

  let(:datastore_content) { File.read(datastore_file).strip }

  subject { described_class.new(datastore_file) }

  describe "#save" do

    let(:datastore_file) do
      File.expand_path('fixtures/datastore.dat', File.dirname(__FILE__))
    end

    after do
      File.delete(datastore_file) if File.exist?(datastore_file)
    end

    it "stores service status as a CSV line" do
      Timecop.freeze(Time.utc(2018, 1, 1, 0, 0, 0)) do
        status = ServiceStatus.new('Github', 'good')
        subject.save(status)
      end

      expect(datastore_content).to eq(
        "Github;good;2018-01-01 00:00:00 UTC"
      )
    end

  end

  describe "#load_each" do

    let(:datastore_file) do
      File.expand_path('fixtures/datastore_data.dat', File.dirname(__FILE__))
    end

    let(:all_statuses) do
      read_lines = []
      subject.load_each do |read_status|
        read_lines << read_status
      end
      read_lines
    end

    it "reads all lines as ServiceStatus objects" do
      expect(all_statuses.count).to eq 2
    end

    it "correctly reads service name" do
      expect(all_statuses[0].service_name).to eq "Bitbucket"
    end

    it "correctly reads service status" do
      expect(all_statuses[l].status).to eq "good"
    end

    it "correctly reads time" do
      expect(all_statuses[l].time).to eq Time.utc(2018, 1, 1, 0, 0, 2)
    end
  end

end
