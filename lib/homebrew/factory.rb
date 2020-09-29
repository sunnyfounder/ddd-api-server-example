require 'dry-initializer'

module Homebrew
  class Factory
    extend ::Dry::Initializer

    param :db_object, default: proc { nil }

    def build
      OpenStruct.new
    end
  end
end
