# frozen_string_literal: true
module LB
  module RB
    # Page view
    class Page < View
      extend LB::RB::Registry::Registration[:page]

      def title
        t = LB::RB.t.page
        self.class.page_key.split('/').each do |key|
          t = t.send(key)
        end

        t.title
      end
    end
  end
end
