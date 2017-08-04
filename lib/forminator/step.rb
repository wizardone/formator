require 'hanami/validations'

module Forminator

  class InvalidStep < StandardError; end

  class Step

    include ::Hanami::Validations

    attr_reader :params

    def self.call(params)
      validity = new(params).valid?

      [validity, params]
    end

    def valid?
      validate.success?
    end

    def persist?
      false
    end

    def persist
      Forminator.config.persist.call
    end
  end
end
