# frozen_string_literal: true
module LB
  module RB
    # Main routing entry point
    class App < LB::RB::Route
      route do |r|
        r.i18n_set_locale_from(:http)

        r.public
      end
    end
  end
end
