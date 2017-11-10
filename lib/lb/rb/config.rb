# frozen_string_literal: true

module LB
  module RB
    # Configuration
    class Config < Dry::Struct
      RequiredString = Types::Strict::String.constrained(min_size: 1)

      attribute :base_path, Types::Strict::String
      attribute :image_base_path, Types::Strict::String
      attribute :public_path, Types::Strict::String
      attribute :template_path, Types::Strict::String

      def self.load(root, name, env)
        path = File.join(File.join(root, 'config'), "#{name}.yml")
        yaml = File.exist?(path) ? YAML.load_file(path) : {}

        new(config(yaml, env))
      end

      def self.config(yaml, env)
        schema.keys.each_with_object({}) do |key, memo|
          memo[key] = value_for(yaml, env, key)
        end
      end

      def self.value_for(yaml, env, key)
        ENV.fetch(
          key.to_s.upcase,
          yaml.fetch(env.to_s, {})[key.to_s]
        )
      end
    end
  end
end
