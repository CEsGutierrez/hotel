# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "time"
require "minitest/pride"
require "simplecov"
SimpleCov.start do 
 add_filter 'test/' #Ignores coverage gap for tests
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/block'
require_relative '../lib/booker'
require_relative '../lib/date_mediator'
require_relative '../lib/reporter'
require_relative '../lib/reservation'
require_relative '../lib/room'

