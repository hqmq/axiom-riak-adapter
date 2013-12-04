require 'spec_helper'
require 'support/riak_connection'

describe Axiom::Adapter::Riak, 'reading from riak' do
  include_context "riak_connection"
  let(:bucket){ riak.bucket('people') }
  let(:gateway){ adapter['people'] }

  before(:each) do
    mary = bucket.new('mary')
    mary.data = {first_name: 'mary', last_name: 'contrary'}
    mary.store
    joe = bucket.new('joe')
    joe.data = {first_name: 'joe', last_name: 'smith'}
    joe.store

    adapter['people'] = Axiom::Relation::Base.new(:people, [
      [:first_name,String],
      [:last_name,String]
    ])
  end

  it "can read all entries" do
    gateway.restrict(first_name: 'mary').count.should == 1
    mary = gateway.restrict(first_name: 'mary').to_a.first
    mary['last_name'].should == 'contrary'
  end
end
