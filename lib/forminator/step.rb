require 'hanami/validations'

module Forminator
  class Step

    include ::Hanami::Validations

    def validate
      super
    end

    def ok?
      validate.success?
    end
  end
end
