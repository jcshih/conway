require 'generation'

describe 'empty generation' do
  it 'has 0 population after tick' do
    gen = Generation.new([])
    next_gen = gen.tick
    expect(next_gen.population).to eq(0)
  end
end
