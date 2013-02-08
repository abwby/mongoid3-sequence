require "bundler/setup"
require "test/unit"
require "mongoid"

require File.expand_path("../../lib/mongoid-sequence", __FILE__)

Mongoid.configure do |config|
  config.load! "test/mongoid.yml", :test
end

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

class BaseTest < Test::Unit::TestCase
  def test_default; end # Avoid "No tests were specified." on 1.8.7

  def teardown
    Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
