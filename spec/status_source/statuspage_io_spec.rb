require 'timecop'

# TODO: extract shared_example_for "status checker" and share it with github
describe StatusSource::StatuspageIo do

  FakeResponse = Struct.new(:code, :body)

  let(:http_client) do
    double(get_response: FakeResponse.new(response_code, File.read(response_filepath)))
  end

  class FakeStatusChecker < described_class
    def api_url
      'https://google.com'
    end

    def service_name
      'Test service'
    end
  end

  subject do
    FakeStatusChecker.new(http_client).current_status
  end

  context "when statuspage_io is working properly" do
    let(:response_filepath) do
      File.expand_path('../fixtures/statuspage_io/success.txt', File.dirname(__FILE__))
    end
    let(:response_code) { 200 }

    it "returns status received from statuspage_io" do
      expect(subject.status).to eq 'All Systems Operational'
    end

    it "returns the time of request" do
      Timecop.freeze do
        expect(subject.time).to eq Time.now.utc
      end
    end

    it "returns the proper service name" do
      expect(subject.service_name).to eq 'Test service'
    end
  end

  context "when statuspage_io does not serve the response" do
    let(:response_code) { 503 }
    let(:response_filepath) do
      File.expand_path('../fixtures/statuspage_io/empty.txt', File.dirname(__FILE__))
    end

    it "raise a remote error" do
      expect { subject }.to raise_error StatusSource::RemoteError
    end
  end

end
