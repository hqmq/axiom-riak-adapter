require 'bundler/setup'
require 'axiom-riak-adapter'

RSpec.configure do |c|
  c.order = :rand
  c.color = true
end
