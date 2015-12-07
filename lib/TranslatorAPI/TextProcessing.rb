require 'json'
require "TranslatorAPI/Error/YandexError"
require "TranslatorAPI/Requests/SentPostRequests"

module TranslatorAPI
  class TextProcessing
    
    HOST = "https://translate.yandex.net/api/v1.5/tr.json/"
    MAX_TEXT = 10_000  
  
    def self.new(*arg)
      obj = super(*arg)
    rescue => ex
      obj = Error::YandexError.new.handling_error(ex, obj)    
    ensure
      obj  
    end
  
    def initialize(key, lang = "ru")
      @key = key
      @error = Error::YandexError.new
      @yandex = Requests::SentPostRequests.new
      @lang = lang 
      list = get_list     
      fail ArgumentError, "Key is invalid or blocked" unless list[0] && list[1] 
      fail ArgumentError, "Incorrect reduction. New return NilClass" if list[0] == nil && list[1]       
    end
  
    def get_list      
      json = JSON.parse @yandex.post_request("#{HOST}getLangs", { 'key' => @key, 'ui' => @lang })    
                  
      fail Error::YandexError.new, json['message'] if json['code']   
    rescue => ex
      return @error.handling_error(ex), nil
    else             
      return json['langs'], json['dirs']              
    end
  
    def detect(text)
      langs = get_list   
      json = JSON.parse @yandex.post_request("#{HOST}detect", { 'key' => @key, 'text' => text })
   
      fail Error::YandexError.new, json['message'] unless json['code'] == Error::YandexError::CODES[:ok]     
    rescue => ex
      return @error.handling_error ex
    else    
      return langs[0][json['lang']]
    end
  
    def translate(text, lang = @lang, format = "plain")    
      json = JSON.parse @yandex.post_request("#{HOST}translate", { 'key' => @key, 'text' => text, 'lang' => lang, 'format' => format })
    
      fail Error::YandexError.new, json['message'] unless json['code'] == Error::YandexError::CODES[:ok]   
    rescue => ex
      return @error.handling_error ex
    else       
      json['text'].join
    end

  end
end
