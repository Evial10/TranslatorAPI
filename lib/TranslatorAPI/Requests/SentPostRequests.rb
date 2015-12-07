require 'net/http'

module TranslatorAPI
  
  module Requests
  
    class SentPostRequests
        
      def initialize
        @uri = nil    
        @http = nil
      end
  
      def post_request(uri, hash_arg)
        if @uri && @uri == uri
         request hash_arg 
        else 
         connect uri
         request hash_arg
        end
      end  
  
      private      
  
      def connect(uri)    
        @uri = URI.parse(uri)
        @http = Net::HTTP.new(@uri.hostname, @uri.port) 
        @http.use_ssl = true
      end
  
      def request(hash_arg) 
        post = Net::HTTP::Post.new(@uri.path)      
        post.set_form_data hash_arg        
        doc = @http.request(post)     
        doc.body     
      end
    end
  end
end
