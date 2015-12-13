require 'json'
require "translator_api/error/yandex_error"
 
module TranslatorAPI

  class Parser
  
    def initialize(json)
    @json = JSON.parse json
    end
        
    def parse(method_get_list = false)
      fail Error::YandexError.new, @json['message'] if @json['code'] && method_get_list
      fail Error::YandexError.new, @json['message'] if @json['code'] != Error::YandexError::CODES[:ok] && !method_get_list
    rescue => ex      
        return Error::YandexError.new.handling_error(ex)
    else 
      if @json['dirs']
        return @json['langs'], @json['dirs'] 
      elsif @json['text'] 
        return @json['text'].join 
      else
        return @json['lang']  
      end
    end
  
  end

end
