module MessagePub

  class Recipient
  
    attr_accessor :position, :channel, :address, :id, :status
  
    def initialize(options={})
      @position = options[:position]
      @channel = options[:channel]
      @address = options[:address]
      @id = options[:id]
      @status = options[:status]
    end
    
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
