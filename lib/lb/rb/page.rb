# frozen_string_literal: true

module LB
  module RB
    # Base page
    class Page < LB::Project::Page
      LB::Project::View.setup(self)
    end
  end
end
