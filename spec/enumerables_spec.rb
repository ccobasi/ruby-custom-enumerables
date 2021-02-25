#spec/enumerables_spec.rb
require_relative '../app.rb'
require 'rspec'

describe 'Enumerables testing' do
    let(:range) { (1..3) }
    let(:array) { [1, 2, 3] }
    let(:array_clone) { array.clone }
    let(:predicate_block) { proc { |number| number > 1 } }

    describe 'RSPEC# - Method: #my_each' do
        it 'returns an Enumerator if no block is given' do
            expect(array.my_each).to be_an(Enumerator)
        end
        it 'does not mutate the original array' do
            array.my_each { |num| num + 1 }
            expect(array).to eq(array_clone)
        end
    
        it 'returns an Enumerator after applying the block given ' do
            output = ''
            array.each { |number| output += " #{number} " }
            output2 = ''
            array.my_each { |number| output2 += " #{number} " }
            expect(output).to be_eql(output2)
        end
    end

    

end