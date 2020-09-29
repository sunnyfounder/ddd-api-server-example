require 'sidekiq'
require_relative '../usecases/calculator.rb'

module Hello
  module Workers
    class CalculateWorker
      include Sidekiq::Worker

      def perform
        result = Hello::Usecases::Calculator.new.call(method: '+', number1: 1, number2: 2)
        puts result
      end
    end
  end
end
