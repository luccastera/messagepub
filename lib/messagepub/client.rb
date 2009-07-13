# This module encapsulates functionality to interface with the MessagePub Rest API.
module MessagePub

  # Implements a client object to communicate with the MessagePub Rest API.
  class Client
    include HTTParty
    base_uri 'messagepub.com'
    format :xml
    headers 'Content-Type' => 'text/xml', 'Accept' => 'text/xml'
    
    # To create a new MessagePub::Client, you need to pass in your MessagePub API Key.
    # 
    # <tt>client = MessagePub::Client.new('YOURAPIKEYGOESHERE')</tt>
    #
    # You can also set it in your environment by putting the following line in your .bashrc file.
    #
    # <tt>export MESSAGEPUB_API_KEY=YOURKEY</tt>
    #
    # In that case, you can initialize a new client by simply saying:
    #
    # <tt>client = MessagePub::Client.new</tt>
    def initialize(api_key=nil)
      @api_key = api_key || ENV['MESSAGEPUB_API_KEY']
      self.class.basic_auth @api_key, 'password'
    end
    
    
    # Gets a list of the last notifications sent
    # Returns an array of MessagePub::Notification objects.
    #
    # <tt>client = MessagePub::Client.new('YOURAPIKEYGOESHERE')</tt>
    #
    # <tt>n = client.notifications</tt>    
    def notifications
      response = self.class.get('/notifications.xml')
      notifications_array = []
      response['notifications'].each do |note|
        new_note = Notification.new(:body => note["body"],
                                    :subject => note["subject"],
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
    
    # Gets the notification for the unique id specified.
    # Returns a MessagePub::Notification object.
    # <tt>my_notification = client.notification(4)</tt>
    def notification(id)
      response = self.class.get("/notifications/" + id.to_s + ".xml")
      note = response["notification"]
      new_note = Notification.new( :body => note["body"],
                                   :subject => note["subject"],
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
    
    # Cancel the notification for the unique id specified.
    # Returns true if the notification was cancelled, false otherwise.
    # <tt>cancelled = client.cancel_notification(4)</tt>
    def cancel(id)
      response = self.class.delete("/notifications/" + id.to_s + ".xml")
      response.is_a?(Hash) && response.empty?
    end
    
    # Creates a new notification.
    #
    # <tt>note = MessagePub::Notification.new</tt>
    #
    # <tt>note.body = 'The servers are down.'</tt>
    #
    # <tt>note.escalation = 15</tt>
    #
    # <tt>note.save</tt>
    #
    # <tt>note.add_recipient(MessagePub::Recipient.new(:position => 1, :channel => 'aim', :address => 'username'))</tt>
    #
    # <tt>note.add_recipient(MessagePub::Recipient.new(:position => 1, :channel => 'email', :address => 'joe@example.com'))</tt>
    #
    # <tt>client.create!(note)</tt>
    def create!(note)
      self.class.post('/notifications.xml', :body => note.to_xml)
    end
    
    # Gets a list of the latest replies to your notifications.
    # Returns an array of MessagePub::Reply objects
    #
    # <tt>my_replies = client.replies</tt>
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
