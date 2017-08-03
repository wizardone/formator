require 'hanami/validations'

module Forminator

  class InvalidStep < StandardError; end

  class Step

    include ::Hanami::Validations

    attr_reader :params

    def self.call(params)
      new(params).validate
    end

    def initialize(params)
      @params = params
    end

    def validate
      super
    end

    def ok?
      validate.success?
    end
  end
end
