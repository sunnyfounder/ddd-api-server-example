require 'ostruct'
require 'dry/monads/all'

module Homebrew
  class Usecase
    include ::Dry::Monads
    include ::Dry::Monads::Do

    attr_reader :response
    def initialize
      @response = UsecaseResponse.new
    end

    def call(*args)
      Success(yield(steps(*args)))
    rescue ::Dry::Monads::Do::Halt
      raise
    rescue StandardError => e
      Failure(e)
    end

    def create; end

    def save; end

    protected

    def result(data)
      Success(response.status!(:success).data!(data))
    end

    def steps; end

    private # rubocop:disable Lint/UselessAccessModifier

    class UsecaseResponse < OpenStruct
      def initialize
        super()
      end

      def status!(input_status)
        self.status = input_status.to_s
        self
      end

      def message!(input_msg)
        self.message = input_msg
        self
      end

      def data!(input_data)
        self.data = input_data
        self
      end

      def success?
        return true if status == 'success'

        false
      end

      def fail?
        return true if status == 'failed'

        false
      end
    end
  end
end
