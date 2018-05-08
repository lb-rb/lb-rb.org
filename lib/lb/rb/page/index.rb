# frozen_string_literal: true

module LB
  module RB
    class Page
      # The index page
      class Index < self
        setting :template, 'index'

        register_page_as :index
        register_view_as :index
      end
    end
  end
end
