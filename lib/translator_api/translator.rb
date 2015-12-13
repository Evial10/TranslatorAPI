require "translator_api/requests/connect"
require "translator_api/parser"

module TranslatorAPI
  class Translator    
    
    MAX_TEXT = 10_000  
  
    def self.new(*arg)
      obj = super(*arg) 
    rescue 
      obj = nil   
    ensure
      obj  
    end
  
    def initialize(key, lang = "ru")
      @yandex = Requests::Connect.new key
      @lang = lang       
      list = get_list     
      fail ArgumentError if list.instance_of? NilClass 
      if list.instance_of? Array
        fail ArgumentError unless list[0]
      end              
    end
  
    def get_list      
     Parser.new(@yandex.get_list(@lang)).parse(true)  
    end
  
    def detect(text)
      get_list[0][Parser.new(@yandex.detect(text)).parse] 
    end
  
    def translate(text, lang = @lang)    
      Parser.new(@yandex.translate(text, lang)).parse  
    end

  end
end
