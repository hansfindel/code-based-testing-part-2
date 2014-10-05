require 'rails_helper'

RSpec.describe Optimization do

  it '#optimize' do
    arr1 = [{ value: 1 }, { value: 2 }, { value: 3 }]

    o1 = Optimization.new(arr1, :value, 1)
    o1.run
    expect(o1.best[:fitness]).to eq(0)

    o1 = Optimization.new(arr1, :value, 2)
    o1.run
    expect(o1.best[:fitness]).to eq(0)

    o1 = Optimization.new(arr1, :value, 3)
    o1.run
    expect(o1.best[:fitness]).to eq(0)

    o1 = Optimization.new(arr1, :value, 4)
    o1.run
    expect(o1.best[:fitness]).to eq(0)

    o1 = Optimization.new(arr1, :value, 10)
    o1.run
    expect(o1.best[:fitness]).to eq(0)
  end

  context '#check_if_run' do

    it 'should return false if multiple or exact' do
      o = Optimization.new([{ value: 1 }, { value: 2 }, { value: 3 }], :value, 2)
      expect(o.check_if_run).to eq(false)
      expect(o.best).to_not eq(nil)

      o = Optimization.new([{ value: 1 }, { value: 2 }, { value: 3 }], :value, 1)
      expect(o.check_if_run).to eq(false)
      expect(o.best).to_not eq(nil)

      o = Optimization.new([{ value: 1 }, { value: 2 }, { value: 3 }], :value, 3)
      expect(o.check_if_run).to eq(false)
      expect(o.best).to_not eq(nil)
    end

    it 'should return true if not multiple nor exact amount' do
      o = Optimization.new([{ value: 1 }, { value: 2 }, { value: 3 }], :value, 13)
      expect(o.check_if_run).to eq(true)
      expect(o.best).to eq(nil)
    end

  end

  it '#evaluate_solution_sum' do
    a = [{ value: 1 }, { value: 2 }, { value: 3 }]
    o = Optimization.new(a, :value, 13)
    expect(o.evaluate_solution_sum({ objects: a })).to eq(6)
  end

  context '#fitness' do

    it 'should be a valid fitness' do
      a = [{ value: 1 }, { value: 2 }, { value: 3 }]
      o = Optimization.new(a, :value, 4)
      expect(o.fitness({ objects: a })).to eq(2)
    end

    it 'should be penalized' do
      a = [{ value: 1 }, { value: 2 }, { value: 3 }]
      o = Optimization.new(a, :value, 100)
      expect(o.fitness({ objects: a })).to eq(Optimization.penalized_fitness)
    end

  end


  it '#tournament with valid fitness' do
    a = [{ value: 1 }, { value: 2 }, { value: 3 }]
    o = Optimization.new(a, :value, 4)
    p1 = { objects: [a.second, a.second] }
    o.set_fitness(p1)
    p2 = { objects: [a.second, a.third]}
    o.set_fitness(p2)

    expect(o.tournament(p1, p2)).to eq(p1)
    expect(o.tournament(p2, p1)).to eq(p1)
  end

  it '#tournament with invalid fitness' do
    a = [{ value: 1 }, { value: 2 }, { value: 3 }]
    o = Optimization.new(a, :value, 20)
    p1 = { objects: [a.second, a.second] }
    o.set_fitness(p1)
    p2 = { objects: [a.second, a.third]}
    o.set_fitness(p2)

    expect(o.tournament(p1, p2)).to eq(p2)
    expect(o.tournament(p2, p1)).to eq(p1)
  end



end
