require 'spec_helper'
require 'support/people'

describe Axiom::Adapter::Riak, 'reading from riak' do
  include_context "people"

  it "can read all entries" do
    gateway = people_gateway

    mary = gateway.restrict(first_name: 'mary').to_a.first
    mary['last_name'].should == 'contrary'
    mary['key'].should == 'mary'

    joe = gateway.restrict(first_name: 'joe').to_a.first
    joe['key'].should == 'joe'
    joe['first_name'].should == 'joe'
    joe['last_name'].should == 'smith'
  end
end
