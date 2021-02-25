# spec/enumerables_spec.rb
require_relative '../app'
require 'rspec'

describe 'Enumerables testing' do
  let(:range) { (1..3) }
  let(:array) { [1, 2, 3] }
  let(:array_clone) { array.clone }
  let(:predicate_block) { proc { |number| number > 1 } }
  let(:word_array) { %w[mini portable table] }
  let(:falsy_array) { [false, nil] }

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

  describe 'RSPEC# - Method: #my_all' do
    context 'No block is given' do
      it 'does return true' do
        expect(array.my_all?).to be true
      end
    end

    context 'When a truthy array is given without a block' do
      it 'does return false' do
        expect(array.all?).to be_eql array.my_all?
      end
    end

    context 'When a falsy array is given without a block' do
      it 'does return true' do
        expect(falsy_array.all?).to be_eql falsy_array.my_all?
      end
    end

    context 'When a class is given' do
      it 'does return true' do
        expect(word_array.all?(String)).to be_eql word_array.my_all? String
      end

      it 'does return false' do
        expect(word_array.all?(Integer)).to be_eql word_array.my_all? Integer
      end
    end
  end

  describe 'RSPEC# - Method: #my_any' do
    context 'No block is given' do
      it 'does return true' do
        expect(array.my_any?).to be true
      end
    end

    context 'When a truthy array is given without a block' do
      it 'does return true' do
        expect(array.my_any?).to be_eql array.any?
      end
    end

    context 'When a falsy array is given without a block' do
      it 'does return false' do
        expect(falsy_array.any?).to be_eql falsy_array.my_any?
      end
    end

    context 'When a class is given' do
      it 'does return true' do
        expect(word_array.any?(String)).to be_eql word_array.my_any? String
      end

      it 'does return false' do
        expect(word_array.any?(Integer)).to be_eql word_array.my_any? Integer
      end
    end
  end

  describe 'RSPEC# - Method: #my_none' do
    context 'No block is given' do
      it 'does return false' do
        expect(array.my_none?).to be false
      end
    end

    context 'When a truthy array is given without a block' do
      it 'does return false' do
        expect(array.none?).to be_eql array.my_none?
      end
    end

    context 'When a falsy array is given without a block' do
      it 'does return true' do
        expect(falsy_array.none?).to be_eql falsy_array.my_none?
      end
    end

    context 'When a class is given' do
      it 'does return true' do
        expect(array.my_none?(String)).to be array.my_none?(String)
      end

      it 'does returns true' do
        expect(array.my_none?(Numeric)).to be array.my_none?(Numeric)
      end

      it 'does return false' do
        array.push 'word goes here'
        expect(array.my_none?(String)).to be array.my_none?(String)
      end
    end
  end

  describe 'RSPEC# - Method: #my_count' do
    context 'When an array is given' do
      it 'does count the elements' do
        expect(array.count).to be array.my_count
      end
    end

    context 'When a range is given' do
      it 'does count the elements' do
        expect(range.count).to be range.my_count
      end
    end

    context 'When a Numeric argument is given' do
      it 'does return true' do
        expect(array.count(1)).to be array.my_count 1
      end
    end

    context 'When a block is given' do
      it 'does return true' do
        expect(array.count(&predicate_block)).to be array.my_count(&predicate_block)
      end
    end
  end

  describe 'RSPEC# - Method: #my_map' do
    context 'When an array is given' do
      it 'does return a new array with the elements that meet the &block condition' do
        expect(array.my_map(&predicate_block)).to eq array.map(&predicate_block)
      end
    end

    context 'When a range is given' do
      it 'does return a new array with the elements that meet the &block condition' do
        expect(range.my_map(&predicate_block)).to eq range.map(&predicate_block)
      end
    end

    context 'When no block is given' do
      it 'does return an Enumerator' do
        expect(array.my_map).to be_an(Enumerator)
      end
    end

    context 'When a block and a &block are given' do
      it 'does execute only the proc' do
        expect(array.my_map(predicate_block) { |num| num > 1 }).to eq array.map(&predicate_block)
      end

      it 'does return a new array' do
        array.my_map(&predicate_block)
        expect(array).to be_eql cloned_array
      end
    end
  end

  describe 'RSPEC# - Method: #my_inject' do
    let(:biggest_number) { proc { |acc, number| acc > number ? acc : number } }

    context 'When no block or argument is given' do
      it 'does raise a "LocalJumpError" error' do
        expect { array.my_inject }.to raise_error(LocalJumpError)
      end
    end

    it 'does return the biggest number' do
      expect(array.my_inject(&biggest_number)).to eq array.inject(&biggest_number)
    end

    it 'does return a new array' do
      cloned_array = array.clone
      array.my_inject { |acc, number| acc + number }
      expect(array).to be_eql cloned_array
    end

    context 'When a block is given' do
      let(:add_block) { proc { |acc, number| acc + number } }
      context 'with an initial value' do
        it 'does return return an array where the initial value and blocked is used' do
          expect(range.my_inject(10, &add_block)).to eq range.inject(10, &add_block)
        end
      end

      context 'without an initial value' do
        it 'combines all elements of enum by applying a binary operation, specified by a block' do
          expect(array.my_inject(&add_block)).to eq array.inject(&add_block)
        end
      end
    end

    context 'When a symbol is given' do
      context 'with an initial value' do
        it 'does return an array where the elements fulfill the &block condition' do
          expect(array.my_inject(10, :+)).to eq array.inject(10, :+)
        end
      end
    end
  end

  describe 'RSPEC# - Method: #multiply_els' do
    it 'does multiply all the elements' do
      expect(multiply_els(array)).to eq 6
    end
  end
end
