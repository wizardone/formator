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

    def persist(object)
      config.persist.(object)
    end
  end
end
