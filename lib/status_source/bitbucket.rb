module StatusSource
  class Bitbucket < StatuspageIo

    def api_url
      'https://bqlf8qjztdtr.statuspage.io/api/v2/status.json'
    end

    def service_name
      'Bitbucket'
    end

  end
end
