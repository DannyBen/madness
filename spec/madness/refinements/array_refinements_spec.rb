require 'spec_helper'

describe ArrayRefinements do
  using described_class

  describe '#nat_sort' do
    subject { %w[10 1 2 3] }

    it 'sorts naturally' do
      expect(subject.nat_sort).to eq %w[1 2 3 10]
    end
  end
end
