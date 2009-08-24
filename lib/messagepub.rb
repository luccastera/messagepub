$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module MessagePub
  VERSION = '0.0.6'
end

require 'rubygems'
require 'httparty'

require 'messagepub/recipient'
require 'messagepub/notification'
require 'messagepub/reply'
require 'messagepub/client'

