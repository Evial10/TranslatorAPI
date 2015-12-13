module TranslatorAPI

  module Error
  
    class YandexError < StandardError

      CODES = {
       :ok => 200,
        :invalid_key => 401,
        :blocked_key => 402,
        :daily_limit_requests => 403,
        :dailt_limit_scope => 404,
        :max_limit => 413,
        :not_translate => 422,
        :translation_not_suppoted => 501    
      }    
 
      def handling_error(error)
        case error
        when YandexError    
          message_error(error)
          nil                          
        else
          raise error.class, error.message
        end      
      end
  
      private
  
      def message_error(error)
       puts "#{error.class} : #{error.message}"
      end
    end
  end
end
