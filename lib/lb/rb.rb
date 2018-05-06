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
    LB::Project.setup(LB::Project.root_for(__FILE__, 3))
  end
end

require 'lb/rb/app'
require 'lb/rb/page'
require 'lb/rb/page/index'
