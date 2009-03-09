module MessagePub

  # Represents a MessagePub recipient.
  # For more info, visit http://messagepub.com/documentation
  class Recipient
  
    # The position of this recipient in the list of recipients for the notification.
    attr_accessor :position
    
    # The communication channel for the recipient.
    # It can be one of: sms, phone, email, twitter, aim, gchat
    attr_accessor :channel
    
    # The address for recipient.
    # Depending on the channel, this can be a phone number, an email, a username, etc...
    attr_accessor :address
    
    # The unique id for this recipient for that particular notification.
    attr_accessor :id
    
    # The status of this recipient. Can be one of: sending, scheduled, sent, received, or failed
    attr_accessor :status
  
    def initialize(options={})
      @position = options[:position]
      @channel = options[:channel]
      @address = options[:address]
      @id = options[:id]
      @status = options[:status]
    end
    
    # Returns an XML representation of the recipient.
    def to_xml
		  value = '<recipient>'
		  value += '<position>' + self.position.to_s + '</position>'
		  value += '<channel>' + self.channel + '</channel>'
		  value += '<address>' + self.address + '</address>'                
		  value += '</recipient>'
		  value
    end
    
  end
end
