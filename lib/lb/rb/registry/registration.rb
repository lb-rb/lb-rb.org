# frozen_string_literal: true
module LB
  module RB
    class Registry
      # Mixin for registration
      module Registration
        def self.[](registry_name, registry = LB::RB::Registry.new)
          rcmethod = "#{registry_name}_registry_config"
          setup(registry_name, registry, rcmethod)
          define_helpers(registry_name, rcmethod) unless respond_to?(rcmethod)

          self
        end

        def self.define_helpers(registry_name, rcmethod)
          rmethod = "#{registry_name}_registry"

          define_registry_config(rcmethod)
          define_registry(rcmethod, rmethod)
          define_registry_name(registry_name, rcmethod)
          define_registry_as(registry_name, rmethod)
          define_key(registry_name)
        end

        def self.define_registry_config(rcmethod)
          define_method(rcmethod) do
            Registration.instance_variable_get("@#{rcmethod}")
          end
        end

        def self.define_registry(rcmethod, rmethod)
          define_method(rmethod) do
            send(rcmethod).registry
          end
        end

        def self.define_registry_name(registry_name, rcmethod)
          rnmethod = "#{registry_name}_registry_name"
          define_method(rnmethod) do
            send(rcmethod).name
          end
        end

        def self.define_registry_as(registry_name, rmethod)
          define_method("register_#{registry_name}_as") do |key|
            send(rmethod).register(key.to_s, self)
            instance_variable_set("@#{registry_name}_key", key.to_s)
          end
        end

        def self.define_key(registry_name)
          define_method("#{registry_name}_key") do
            instance_variable_get("@#{registry_name}_key")
          end
        end

        def self.setup(registry_name, registry, rcmethod)
          config = Config.new(registry_name, registry)
          Registration.instance_variable_set("@#{rcmethod}", config)
        end

        # Stores the registration configuration
        class Config
          extend Dry::Initializer

          param :name, Dry::Types['coercible.string']
          param :registry
        end
      end
    end
  end
end
