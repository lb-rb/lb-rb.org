# frozen_string_literal: true

require 'bundler/setup'

# Debug
require 'byebug'

# Slim
require 'slim'

require 'lb-project'

# Version
require 'lb/rb/version'

# LB namespace
module LB
  # RB
  module RB
    ROOT = LB::Project.root_for(__FILE__, 3)
    CONFIG_FILE = File.join(ROOT, 'config/application.yml')

    def self.setup
      settings = LB::Project::Settings.new(
        root: ROOT,
        config: LB::Project::Config.load(CONFIG_FILE)
      )
      LB::Project.setup(settings)
    end

    setup
  end
end

require 'lb/rb/app'
require 'lb/rb/page'
require 'lb/rb/page/index'
