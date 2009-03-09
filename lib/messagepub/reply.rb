module MessagePub

  # Represents a MessagePub reply..
  # For more info, visit http://messagepub.com/documentation/replies
  class Reply
    
    # The ID of the notification associated with this reply.
    attr_accessor :notification_id
    
    # The communication channel where this reply was done.
    # Must be one of the following: sms, phone, email, twitter, gchat, aim.
    attr_accessor :channel
    
    # The address for the person that replies.
    # Depending on the channel, this can be a phone number, an email, a username, etc...
    attr_accessor  :address
    
    # The content of the reply.
    attr_accessor :body
    
    # The unique id for this reply.
    attr_accessor :id
  
    def initialize(options={})
      @notification_id = options[:notification_id]
      @channel = options[:channel]
      @address = options[:address]
      @body = options[:body]
      @id = nil
    end
  end

end
