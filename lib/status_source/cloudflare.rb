module StatusSource
  class Cloudflare < StatuspageIo

    def api_url
      'https://yh6f0r4529hb.statuspage.io/api/v2/status.json'
    end

    def service_name
      'Cloudflare'
    end

  end
end
