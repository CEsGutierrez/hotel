require "simplecov"
SimpleCov.start do 
 add_filter 'test/' #Ignores coverage gap for tests
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "date"
require "rake"

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

require_relative '../lib/block'
require_relative '../lib/booker'
require_relative '../lib/date_mediator'
require_relative '../lib/reservation'
require_relative '../lib/room'

