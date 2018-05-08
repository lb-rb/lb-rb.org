#\ -p 3000 -P invalid_public_path_to_disable_shotguns_static_route
# frozen_string_literal: true

root = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH << File.join(root, 'lib')

require 'lb-rb'

run LB::RB::App.freeze.app
