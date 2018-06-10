module StatusSource
  class StatuspageIo

    def initialize(http_client = Net::HTTP)
      @http_client = http_client
    end

    def api_url
      raise NotImplementedError, 'Please implement in the child class'
    end

    def service_name
      raise NotImplementedError, 'Please implement in the child class'
    end

    def current_status
      response = @http_client.get_response(URI(api_url))
      raise RemoteError unless success?(response)

      status_info = JSON.parse(response.body)
      ServiceStatus.new(service_name, status_info["status"]["description"])
    end

    private

    def success?(response)
      response.code.to_i == 200
    end

  end
end
