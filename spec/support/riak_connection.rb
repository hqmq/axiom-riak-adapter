shared_context "riak_connection" do
  let(:riak){ Riak::Client.new(protocol: 'pbc', pb_port: 8087) }
  let(:adapter){ Axiom::Adapter::Riak.new(
    URI.parse('riakpbc://127.0.0.1:8087')
  )}

  before(:each) do
    #truncate the DB
    riak.buckets.each do |bucket|
      bucket.keys.each do |key|
        bucket.delete(key)
      end
    end
  end
end
