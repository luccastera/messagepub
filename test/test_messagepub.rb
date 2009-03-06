require File.dirname(__FILE__) + '/test_helper.rb'

class TestMessagepub < Test::Unit::TestCase

  def setup
    @recipient = MessagePub::Recipient.new(:position => 1, 
                       :channel => 'twitter', 
                       :address => 'luccastera')

    @notification = MessagePub::Notification.new(:body => 'This is a test',
                       :escalation => 20,
                       :postback_url => 'http://messagepub.com/documentation/postback_test')
    
    @reply = MessagePub::Reply.new(:body => 'Test reply', :channel => 'twitter', :address => 'ab')
  end
  
  def test_create_recipient
    assert_equal 1, @recipient.position
    assert_equal 'twitter', @recipient.channel
    assert_equal 'luccastera', @recipient.address
  end
  
  def test_create_notification
    assert_equal 'This is a test', @notification.body
    assert_equal 20, @notification.escalation
    assert_equal 'http://messagepub.com/documentation/postback_test',@notification.postback_url
  end
  
  def test_add_recipient_to_notification
    assert_equal 0, @notification.recipients.size
    @notification.add_recipient(@recipient)
    assert_equal 1, @notification.recipients.size
  end
  
  def test_create_reply
    assert_equal 'Test reply', @reply.body
    assert_equal 'twitter', @reply.channel
    assert_equal 'ab', @reply.address
  end
  
  
end
