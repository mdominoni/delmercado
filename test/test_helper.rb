ENV['RACK_ENV']  = 'test'
ENV['REDIS_URL'] = "redis://username:password@host:port/db_id"

require_relative '../app'

require 'contest'
require 'malone/test'

class Test::Unit::TestCase
  def setup
    Ohm.flush
    Malone.deliveries.clear
  end
end
