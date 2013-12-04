require 'axiom/adapter/riak/gateway'
module Axiom::Adapter
  class Riak
    extend Axiom::Adapter

    def initialize(uri)
      @client = ::Riak::Client.new(protocol: 'pbc', pb_port: uri.port)
      @schema = {}
    end

    def [](name)
      schema[name]
    end

    def []=(name, relation)
      schema[name] = Gateway.new(relation, self)
    end

    def read(relation)
      attributes = relation.header.map(&:name).map(&:to_s)
      bucket = client.bucket(relation.name.to_s)
      keys = bucket.keys
      hashes = keys.map { |key|
        entry = bucket.get(key)
        hash = entry.data.merge('key' => entry.key)
        hash.values_at(*attributes)
      }
    end

    private
    attr_reader :client, :schema
  end
end
