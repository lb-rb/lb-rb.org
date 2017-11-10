# frozen_string_literal: true
module LB
  module RB
    # Basic key value store
    class Registry
      include Dry::Equalizer(:keys)
      include Enumerable

      attr_reader :keys

      # Error that is raised when key is not found in registry
      class KeyNotFoundError < KeyError
        def initialize(key)
          super("#{key.inspect} doesn't exist in registry")
        end
      end

      def initialize(keys = {})
        @keys = keys
      end

      def each(&block)
        return to_enum unless block
        keys.each { |key| yield(key) }
      end

      def key?(key)
        !key.nil? && keys.key?(key.to_sym)
      end

      def fetch(key)
        raise ArgumentError, 'key cannot be nil' if key.nil?

        keys.fetch(key.to_sym) do
          return yield if block_given?

          raise KeyNotFoundError, key
        end
      end
      alias [] fetch

      def respond_to_missing?(key, include_private = false)
        keys.key?(key) || super
      end

      def register(key, value)
        keys[key] = value
      end

      private

      def method_missing(key, *)
        keys.fetch(key) { super }
      end
    end
  end
end
