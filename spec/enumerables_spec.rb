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

    describe 'RSPEC# - Method: #my_each_with_index' do
        it 'returns an enumerator if no block is given' do
        expect(array.my_each_with_index).to be_an(Enumerator)
        end

        it 'does not mutate the original array' do
        array.my_each_with_index(&predicate_block)
        expect(array).to eq(array_clone)
        end
    end
    
    describe 'RSPEC# - Method: #my_select' do
        it 'does not mutate the original array' do
            array.my_select(&predicate_block)
            expect(array).to be_eql cloned_array
        end

   
        it 'does return an Enumerator' do
            expect(array.my_select).to be_an(Enumerator)
        end

        it 'does filter the same elements' do
            result = array.select(&predicate_block)
            result2 = array.my_select(&predicate_block)
            expect(result).to be_eql result2
        end

        it 'does filter the same elements when given range' do
            result = range.select(&predicate_block)
            result2 = range.my_select(&predicate_block)
            expect(result).to be_eql result2
        end

        it 'does return an Enumerator when given range' do
            expect(range.my_select).to be_an(Enumerator)
        end
    end
 

    

    

end