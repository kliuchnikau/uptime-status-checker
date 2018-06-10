class ServiceStatus

  def initialize(service_name, status_text)
    @service_name = service_name
    @status = status_text
    @time = Time.now.utc
  end

  attr_reader :service_name, :status, :time

  def to_s
    "Service: #{service_name}, Status: #{status}, Check time: #{time}"
  end

end
