require 'dry-initializer'

module Homebrew
  class Adapter
    extend ::Dry::Initializer

    param :relation, default: proc { nil }

    def adapt
      relation.new
    end
  end
end
