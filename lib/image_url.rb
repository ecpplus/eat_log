require 'open-uri'
module ImageUrl
  class << self
    def instagram(url)
      begin
        json = JSON.parse(open('http://instagr.am/api/v1/oembed/?maxwidth=200&url=' + url).read)
        return json['url'].to_s
      rescue OpenURI::HTTPError => e
        Rails.logger.error e.message
      rescue JSON::ParserError => e
        Rails.logger.error e.message
      end
    end
  end

end

