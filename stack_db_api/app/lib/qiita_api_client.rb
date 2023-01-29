class QiitaApiClient
  class HTTPError < StandardError
    def initialize(response)
      super "status=#{response.status} body=#{response.body}"
    end
  end  
  class << self
    def connection
      Faraday::Connection.new('https://qiita.com') do |builder|
        builder.authorization :Bearer, "#{ENV['QIITA_TOKEN']}"
        builder.request :url_encoded
        builder.response :logger
        builder.adapter Faraday.default_adapter
        builder.response :json, :content_type => 'application/json'
      end
    end

    def seed(page)
      response = connection.get('/api/v2/items') do |req|
        req.params[:per_page] = 100
        req.params[:page] = page
        req.params[:query] = "title:個人開発 stocks:>50 created:>2020-01-01 created:<2023-01-02 OR title:ポートフォリオ stocks:>50 created:>2020-01-01 created:<2023-01-02 OR tag:個人開発 stocks:>50 created:>2020-01-01 created:<2023-01-02 OR tag:ポートフォリオ stocks:>50 created:>2020-01-01 created:<2023-01-02"
      end
      if response.success?
        response.body
      else
        raise QiitaApiClient::HTTPError.new(response)
      end      
    end

    def get_items(page)
      response = connection.get('/api/v2/items') do |req|
        req.params[:per_page] = 100
        req.params[:page] = page
        req.params[:query] = "title:個人開発 stocks:>50 OR title:ポートフォリオ stocks:>50 OR tag:個人開発 stocks:>50 OR tag:ポートフォリオ stocks:>50"
      end
      if response.success?
        response.body
      else
        raise QiitaApiClient::HTTPError.new(response)
      end
    end 

  end
end