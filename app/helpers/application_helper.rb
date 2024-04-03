module ApplicationHelper
    def full_title(page_title = ' ')
        base_title = "Ruby on Rails Tutorial Sample App"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end  
    
    def css_class_for_message_type(message_type)
        case message_type
        when 'notice'
          'alert-info' # Change this class to the desired color for notice messages
        when 'success'
          'alert-success' # Change this class to the desired color for success messages
        when 'error'
          'alert-danger' # Change this class to the desired color for error messages
        when 'alert'
          'alert-warning' # Change this class to the desired color for alert messages
        else
          'alert-info' # Default to info color if message type is not recognized
        end
    end
end
