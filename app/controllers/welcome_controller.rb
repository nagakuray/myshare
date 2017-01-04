class WelcomeController < ApplicationController
  require 'open-uri'
  require 'openssl'

  def index
    @slides = get_slide_list
  end

  private
    def get_slide_list
      if params[:q]
        url = EasySettings.url_search_slideshows
        api_param = Hash.new
        api_param["q"] = params[:q]
        api_param["api_key"] = Rails.application.secrets.api_key
        api_param["sharedsecret"] = Rails.application.secrets.sharedsecret
        api_param["ts"] = Time.now.to_i.to_s
        api_param["hash"] = Digest::SHA1.hexdigest(api_param["sharedsecret"]+api_param["ts"])
        api_param["lang"] = "ja"
        # api_param["page"] = 5.to_s
        # api_param["items_per_page"] = 20.to_s

        uri_param = api_param.sort.map {|i| i.join('=')}.join('&')
        uri = url + "?" + URI.escape(uri_param)
        xml = Nokogiri::XML(open(uri))
        slides = xml.xpath("//Slideshow")

        return slides

      end
    end

end
