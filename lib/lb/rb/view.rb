# frozen_string_literal: true
module LB
  module RB
    # Base view
    class View < Dry::View::Controller
      extend LB::RB::Registry::Registration[:view]

      setting :paths, [LB::RB.template_path]
      setting :layout, 'main'

      def view_locals(options)
        options
      end
    end
  end
end
