require 'forminator/version'
require 'forminator/config'
require 'forminator/flow'
require 'forminator/step'

module Forminator

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end
end
