module MessagePub

  class Reply
    
    attr_accessor :notification_id, :channel, :address, :body, :id
  
    def initialize(options={})
      @notification_id = options[:notification_id]
      @channel = options[:channel]
      @address = options[:address]
      @body = options[:body]
      @id = nil
    end
  end

end
