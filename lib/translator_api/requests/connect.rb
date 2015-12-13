require 'net/http'

module TranslatorAPI
  
  module Requests
  
    class Connect
    
      HOST = "https://translate.yandex.net/api/v1.5/tr.json/"
        
      def initialize(key)
        @key = key         
      end
   
      def get_list(lang)
        post_request("#{HOST}getLangs", { 'key' => @key, 'ui' => lang })
      end
      
      def detect(text)
        post_request("#{HOST}detect", { 'key' => @key, 'text' => text })
      end
      
      def translate(text, lang)
        post_request("#{HOST}translate", { 'key' => @key, 'text' => text, 'lang' => lang})    
      end
  
      private
  
      def post_request(uri, hash_arg)
        uri_parse = URI.parse(uri)
        http = Net::HTTP.new(uri_parse.hostname, uri_parse.port) 
        http.use_ssl = true
        post = Net::HTTP::Post.new(uri_parse.path)      
        post.set_form_data hash_arg        
        doc = http.request(post)     
        doc.body 
      end  
     
    end
  end
end
