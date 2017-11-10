# frozen_string_literal: true
require 'json'

require 'bundler/setup'

# Debug
require 'byebug'

# Web
require 'roda'

# r18n
require 'r18n-core'

# Dry
require 'dry-types'
require 'dry-struct'
require 'dry-view'
require 'dry-initializer'

# Slim
require 'slim'

# Utils
require 'yaml'

# Version
require 'lb/rb/version'

# Custom Types
require 'lb/rb/types'

# Config
require 'lb/rb/config'

# LB namespace
module LB
  # RB
  module RB
    CONFIG_NAME = 'application'
    DEFAULT_RACK_ENV = 'development'

    # Get root path
    #
    # @return [dir_name]
    #
    # @api private
    #
    def self.root
      @root ||= File.dirname(
        File.dirname(
          File.dirname(
            File.expand_path(__FILE__)
          )
        )
      )
    end

    # Get template path
    #
    # @return [dir_name]
    #
    # @api private
    #
    def self.template_path
      File.join(root, config.template_path)
    end

    # Get public path
    #
    # @return [dir_name]
    #
    # @api private
    #
    def self.public_path
      File.join(root, config.public_path)
    end

    # Get main configuration
    #
    # @return [Config]
    #
    # @api private
    #
    def self.config
      @config ||= Config.load(root, CONFIG_NAME, rack_env)
    end

    # Get RACK_ENV
    #
    # @return [String]
    #
    # @api private
    #
    def self.rack_env
      @rack_env ||= ENV.fetch('RACK_ENV', DEFAULT_RACK_ENV)
    end

    # Check if rack_env is 'development'
    #
    # @return [Boolean]
    #
    # @api private
    #
    def self.development?
      DEFAULT_RACK_ENV.eql? rack_env
    end

    def self.logger
      @logger ||= create_logger
    end

    def self.create_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger
    end

    def self.t(*params)
      R18n.t(*params)
    end
  end
end

# Site
require 'lb/rb/site'

# Routing
require 'lb/rb/route'
require 'lb/rb/app'

# Registry
require 'lb/rb/registry'
require 'lb/rb/registry/registration'

# Views
require 'lb/rb/view'
require 'lb/rb/page'
require 'lb/rb/page/index'

# Render
require 'lb/rb/render'
