describe ArrayRefinements do
  using described_class
  SortableObject = Struct.new :name

  describe '#nat_sort' do
    subject(:strings) { %w[b 10 1 2 3 a] }

    it 'sorts naturally' do
      expect(subject.nat_sort).to eq %w[1 2 3 10 a b]
    end

    context 'with objects' do
      subject { strings.map { |x| SortableObject.new x } }

      it 'sorts naturally by the requested method name' do
        expect(subject.nat_sort(by: :name).map(&:name)).to eq %w[1 2 3 10 a b]
      end
    end
  end
end
