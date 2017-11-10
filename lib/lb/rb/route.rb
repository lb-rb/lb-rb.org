# frozen_string_literal: true
module LB
  module RB
    # Base route
    class Route < Roda
      plugin :i18n, translations: [File.join(LB::RB.root, 'locales')]
      opts[:root] = LB::RB.root
      plugin :public, root: 'docs'
    end
  end
end
