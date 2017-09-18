require 'hanami/validations'

module Forminator

  class InvalidStep < StandardError; end

  class Step

    include ::Hanami::Validations

    attr_reader :params, :object

    def self.call(object, params, **options)
      step = new(params)
      validity = step.valid?
      if validity && step.persist?
        step.persist(object: object, persist: options[:persist])
      end

      [{ valid: validity }, params]
    end

    def valid?
      validate.success?
    end

    def persist?
      false
    end

    def persist(object:, persist: nil)
      persist&.call(object) ||
      Forminator.config.persist.call(object)
    end
  end
end
