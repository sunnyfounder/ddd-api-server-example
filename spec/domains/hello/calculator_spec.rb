require_relative '../../domain_helper.rb'
# require_relative '../../../domains/hello/usecases/calculator.rb'

RSpec.describe 'calculator' do
  it 'add' do
    usecase = Hello::Usecases::Calculator.new
    result = usecase.call(method: '+', number1: 1, number2: 2).value!
    expect(result).to eq 3
  end
  it 'minus' do
    usecase = Hello::Usecases::Calculator.new
    result = usecase.call(method: '-', number1: 2, number2: 1).value!
    expect(result).to eq 1
  end
end
