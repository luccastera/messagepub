module MessagePub

  class Client
    include HTTParty
    base_uri 'messagepub.com'
    format :xml
    headers 'Content-Type' => 'text/xml', 'Accept' => 'text/xml'
    
    def initialize(api_key)
      @api_key = api_key || ENV['MESSAGEPUB_API_KEY']
      self.class.basic_auth @api_key, 'password'
    end
    
    def notifications
      response = self.class.get('/notifications.xml')
      notifications_array = []
      response['notifications'].each do |note|
        new_note = Notification.new(:body => note["body"],
                                    :send_at => note["send_at"],
                                    :id => note["id"],
                                    :escalation => note["escalation"])
        note["recipients"].each do |rcpt|
          new_note.add_recipient(Recipient.new(:id => rcpt["id"],
                                               :channel => rcpt["channel"],
                                               :address => rcpt["address"],
                                               :status  => rcpt["status"],
                                               :send_at => rcpt["send_at"]))
        end
        notifications_array << new_note        
      end
      notifications_array
    end
    
    def notification(id)
      response = self.class.get("/notifications/" + id.to_s + ".xml")
      note = response["notification"]
      new_note = Notification.new( :body => note["body"],
                                   :id => note["id"],
                                   :send_at => note["send_at"],
                                   :escalation => note["escalation"])
      note["recipients"].each do |rcpt|
        new_note.add_recipient(Recipient.new(:id => rcpt["id"],
                                             :channel => rcpt["channel"],
                                             :address => rcpt["address"],
                                             :status  => rcpt["status"],
                                             :send_at => rcpt["send_at"]))
      end
      new_note       
    end
    
    def create!(note)
      self.class.post('/notifications.xml', :body => note.to_xml)
    end
    
    def replies
      response = self.class.get("/replies.xml")
      replies_array = []
      response['replies'].each do |reply|
        new_reply = Reply.new(:id => reply['id'], :body => reply['body'],
                              :channel => reply['channel'], :address => reply['address'],
                              :notification_id => reply['notification_id'])
        replies_array << new_reply
      end
      replies_array
    end
  
  end

end
