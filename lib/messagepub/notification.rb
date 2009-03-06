module MessagePub

  class Notification
  
    attr_accessor :body, :escalation, :postback_url, :send_at, :id
    attr_reader :recipients
  
    def initialize(options={})
      @body = options[:body]
      @escalation = options[:escalation]
      @postback_url = options[:postback_url]
      @send_at = options[:send_at]
      @recipients = []
      @id = nil
    end
    
    def add_recipient(rcpt)
      @recipients << rcpt if rcpt.class == Recipient        
    end
    
    def to_xml
      value = '<notification>'
      value += '<body>' + self.body + '</body>'
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
