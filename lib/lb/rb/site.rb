# frozen_string_literal: true
module LB
  module RB
    # Site context for templates
    class Site
      include R18n::Helpers

      attr_reader :options

      def initialize(context = {})
        @context = context
      end

      def options
        @options ||= {}
      end

      def [](*args)
        options.fetch(*args)
      end

      def path_for(bundle, type)
        path = 'webpack-assets.json'
        file = File.read(path)
        json = JSON.parse(file)
        LB::RB.config.base_path + json[bundle][type]
      end

      def js_for(bundle)
        path_for(bundle, 'js')
      end

      def css_for(bundle)
        path_for(bundle, 'css')
      end

      def image_path(path)
        "#{LB::RB.config.image_base_path}/#{path}"
      end
    end
  end
end
