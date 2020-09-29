require_relative File.join(Dir.pwd, '/lib/homebrew/init.rb')

module Hello
  module Usecases
    class Calculator < Homebrew::Usecase
      def steps(method:, number1:, number2:)
        @result = yield calculate(method: method, number1: number1, number2: number2)
        Success(@result)
      end

      def calculate(method:, number1:, number2:)
        case method
        when '+'
          Success(number1.to_i + number2.to_i)
        when '-'
          Success(number1.to_i - number2.to_i)
        when '*'
          Success(number1.to_i * number2.to_i)
        when '/'
          Success(number1.to_i.fdiv(number2.to_i))
        else
          Failure(:failed)
        end
      end
    end
  end
end
