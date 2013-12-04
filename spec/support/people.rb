require 'support/riak_connection'
shared_context "people" do
  include_context "riak_connection"

  let(:people_bucket){ riak.bucket('people') }
  let(:people_gateway){ adapter['people'] }

  before(:each) do
    mary = people_bucket.new('mary')
    mary.data = {first_name: 'mary', last_name: 'contrary'}
    mary.store
    joe = people_bucket.new('joe')
    joe.data = {first_name: 'joe', last_name: 'smith'}
    joe.store

    adapter['people'] = Axiom::Relation::Base.new(:people, [
      [:first_name,String],
      [:last_name,String]
    ])
  end
end
