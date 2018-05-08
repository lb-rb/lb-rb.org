# frozen_string_literal: true
# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'

  SimpleCov.start do
    command_name 'spec:unit'

    add_filter 'config'
    add_filter 'spec'

    minimum_coverage 100
  end
end

$LOAD_PATH << 'lib'

ENV['RACK_ENV'] = 'test'

require 'lb/rb'

require 'devtools/spec_helper'
require 'bogus/rspec'

require 'rack/test'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

SPEC_ROOT = Pathname(__FILE__).dirname

Capybara.app = LB::RB::App.app
Capybara.server_port = 3001
Capybara.save_path = SPEC_ROOT.join('../tmp/capybara-screenshot')
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

def keep_count
  return 9_999_999 if ENV.key?('SCREENSHOTS')
  10
end

Capybara::Screenshot.prune_strategy = { keep: keep_count }
FileUtils.mkdir_p SPEC_ROOT.join('../log')

def phantomjs_options
  return [] if ENV.key?('SCREENSHOTS')
  %w[--load-images=no]
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    inspector: true,
    js_errors: true,
    timeout: 60,
    phantomjs_logger: File.open(SPEC_ROOT.join('../log/phantomjs.log'), 'a'),
    phantomjs_options: phantomjs_options,
    window_size: [1600, 768]
  )
end

Bogus.configure do |config|
  config.search_modules << LB::RB
end

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

RSpec.configure do |config|
  config.include(SpecHelper)
  config.extend(SessionScenario, :with_session)
  config.mock_framework = :rspec

  config.include Rack::Test::Methods, type: :request
  config.include Rack::Test::Methods, Capybara::DSL, type: :feature
  config.before :suite do
    required_phantomjs_version = '2.1.1'
    phantomjs_versions = `phantomjs -v`
    required_version = Gem::Version.new(required_phantomjs_version)
    if Gem::Version.new(phantomjs_versions) < required_version
      puts "\e[31mWARN: Using phantomjs #{phantomjs_versions} which is < "\
        "#{required_phantomjs_version}, please upgrade\e[0m"
      exit(false)
    end
    LB::RB::App.freeze
  end
end
