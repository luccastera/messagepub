module MessagePub

  # Represents a MessagePub notification.
  # For more info, visit http://messagepub.com/documentation
  class Notification  
    
    # The body of the message to send.
    attr_accessor :body
    
    # The subject of the message to send (for emails only)
    attr_accessor :subject
    
    # The amount of time (in minutes) to wait before sending to the next recipient in the list.
    attr_accessor :escalation
    
    # If postback_url is set in your account settings, this is the URL where MessagePub will post
    # any replies it gets for this notification. 
    # For more info, visit http://messagepub.com/documentation/replies.
    attr_accessor :postback_url
    
    # The time in UTC at which the notification will be sent.
    attr_accessor :send_at
    
    # The unique id for the notification.
    attr_accessor :id
    
    # The array of recipients to which this notification will go to.
    attr_reader :recipients
  
    def initialize(options={})
      @body = options[:body]
      @subject = options[:subject]
      @escalation = options[:escalation]
      @postback_url = options[:postback_url]
      @send_at = options[:send_at]
      @recipients = []
      @id = nil
    end
    
    def add_recipient(rcpt)
      @recipients << rcpt if rcpt.class == Recipient        
    end
    
    # Returns an XML representation of the notification that can be POSTed to the REST API.    
    def to_xml
      value = '<notification>'
      value += '<body>' + self.body + '</body>'
      value += '<subject>' + self.subject + '</subject>' unless self.subject.blank?
      value += '<escalation>' + self.escalation.to_s + '</escalation>' if self.escalation
      value += '<postback_url>' + self.postback_url + '</postback_url>' if self.postback_url
      value += '<send_at>' + self.send_at + '</send_at>' if self.send_at
      value += '<recipients>'
      self.recipients.each do |rcpt|
        value += rcpt.to_xml
      end
      value += '</recipients></notification>'
      value            
    end
  
  end

end
