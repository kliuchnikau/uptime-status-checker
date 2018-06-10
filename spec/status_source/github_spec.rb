require 'timecop'

describe StatusSource::Github do

  FakeResponse = Struct.new(:body)

  let(:http_client) do
    double(get_response: FakeResponse.new(File.read(response_filepath)))
  end

  subject do
    described_class.new(http_client).current_status
  end

  context "when github is working properly" do
    let(:response_filepath) do
      File.expand_path('../fixtures/github/success.txt', File.dirname(__FILE__))
    end

    it "returns status received from github" do
      expect(subject.status).to eq "good"
    end

    it "returns the time of request" do
      Timecop.freeze do
        expect(subject.time).to eq Time.now.utc
      end
    end

    it "returns the proper service name" do
      expect(subject.service_name).to eq "Github"
    end
  end

end
