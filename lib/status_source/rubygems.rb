module StatusSource
  class Rubygems < StatuspageIo

    def api_url
      'https://pclby00q90vc.statuspage.io/api/v2/status.json'
    end

    def service_name
      'RubyGems'
    end

  end
end
