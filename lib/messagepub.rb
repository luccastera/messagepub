$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Messagepub
  VERSION = '0.0.2'
end

require 'rubygems'
require 'httparty'

require 'messagepub/recipient'
require 'messagepub/notification'
require 'messagepub/reply'
require 'messagepub/client'

