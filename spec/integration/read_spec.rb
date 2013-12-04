require 'spec_helper'

describe Axiom::Adapter::Riak, 'reading from riak' do
  let(:client){ Riak::Client.new(:protocol => "pbc", :pb_port => 8087) }
  let(:bucket){ client.bucket('people') }
  let(:adapter){ described_class.new( URI.parse("riakpbc://127.0.0.1:8087") ) }
  let(:gateway){ adapter['people'] }

  before(:each) do
    bucket.keys.each{|k| bucket.delete(k)} #remove everything from the bucket
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
