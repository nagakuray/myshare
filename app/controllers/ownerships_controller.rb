class OwnershipsController < ApplicationController
  require 'open-uri'
  before_action :get_slide_list, only: [:new]

  def new
  end

  private
    def get_slide_list
      if params[:q]
        url ="https://www.slideshare.net/api/2/search_slideshows"
        api_param = Hash.new
        api_param["q"] = params[:q]
        api_param["api_key"] = 'DF37gXpB'
        api_param["sharedsecret"] = 'MAcsjIcU'
        api_param["ts"] = Time.now.to_i.to_s
        api_param["hash"] = Digest::SHA1.hexdigest(api_param["sharedsecret"]+api_param["ts"])
        api_param["lang"] = "ja"

        uri_param = api_param.sort.map {|i| i.join('=')}.join('&')
        uri = url + "?" + URI.escape(uri_param)
        xml = Nokogiri::XML(open(uri))
        @slides = xml.xpath("//Slideshow")
      end
    end

end
