describe ArrayRefinements do
  using described_class

  let(:sortable) do
    Class.new do
      attr_reader :name

      def initialize(name) = @name = name
    end
  end

  describe '#nat_sort' do
    subject(:strings) { %w[b 10 1 2 3 a] }

    let(:expected) { %w[1 2 3 10 a b] }

    it 'sorts naturally' do
      expect(subject.nat_sort).to eq expected
    end

    context 'with objects' do
      subject { strings.map { |x| sortable.new x } }

      it 'sorts naturally by the requested method name' do
        expect(subject.nat_sort(by: :name).map(&:name)).to eq expected
      end
    end
  end
end
