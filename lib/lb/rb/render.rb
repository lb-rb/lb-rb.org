# frozen_string_literal: true
module LB
  module RB
    # Render
    class Render
      def call
        Page.page_registry.each do |name, klass|
          page = klass.new
          File.write(file_for(name), page.call(options(page)))
        end
      end

      def file_for(name)
        File.expand_path("#{name}.html", LB::RB.public_path).tap do |file|
          FileUtils.mkdir_p File.dirname(file)
        end
      end

      def options(page, locals = {})
        {
          context: ::Struct.new(:site, :page).new(LB::RB::Site.new, page),
          locals: locals
        }
      end
    end
  end
end
