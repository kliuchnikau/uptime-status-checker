require 'net/http'
require 'json'

module StatusSource
  class Github

    def initialize(http_client = Net::HTTP)
      @http_client = http_client
    end

    API_URL = "https://status.github.com/api/status.json".freeze
    SERVICE_NAME = "Github".freeze

    def current_status
      response = @http_client.get_response(URI(API_URL))
      github_status = JSON.parse(response.body)

      ServiceStatus.new(SERVICE_NAME, github_status["status"])
    end

  end
end
