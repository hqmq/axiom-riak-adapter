require 'bundler/setup'
require 'axiom-riak-adapter'

Riak.disable_list_keys_warnings = true

RSpec.configure do |c|
  c.order = :rand
  c.color = true
end
