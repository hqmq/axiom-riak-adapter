require 'spec_helper'

describe 'reading from riak' do
  let(:client){ Riak::Client.new(:protocol => "pbc", :pb_port => 8087) }
  let(:bucket){ client.bucket('people') }
  before(:each) do
    bucket.keys.each{|k| bucket.delete(k)} #remove everything from the bucket
    mary = bucket.new('mary')
    mary.data = {first_name: 'mary', last_name: 'contrary'}
    mary.store
    joe = bucket.new('joe')
    joe.data = {first_name: 'joe', last_name: 'smith'}
    joe.store
  end

  it "can read all entries" do
    relation.to_a.should == [
      ['mary', 'contrary'],
      ['joe', 'smith']
    ]
  end
end
