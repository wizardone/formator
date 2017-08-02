require 'formator/version'
require 'formator/config'
require 'formator/flow'
require 'formator/step'

module Formator

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config
    end
  end
end
