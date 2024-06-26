describe Breadcrumbs do
  subject { described_class.new('one/two/three') }

  describe '#links' do
    let(:links) { subject.links }

    it 'returns an array of Breadcrumb structs' do
      expect(links).to be_an Array
      expect(links.count).to eq 4
      expect(links.first).to be_a described_class::Breadcrumb
    end

    it 'adds a home link' do
      expect(links.first.label).to eq 'Home'
      expect(links.first.href).to eq '/'
    end

    it 'adds a link to all elements except the last one' do
      expect(links[1].label).to eq 'one'
      expect(links[1].href).to eq '/one/'
      expect(links[2].label).to eq 'two'
      expect(links[2].href).to eq '/one/two/'
      expect(links[3].label).to eq 'three'
      expect(links[3].href).to be_nil
    end

    context 'with sorted elements' do
      subject { described_class.new('1. one/2. two/3. three') }

      it 'removes sorting markers from labels' do
        expect(links[1].label).to eq 'one'
        expect(links[1].href).to eq '/1. one/'
        expect(links[2].label).to eq 'two'
        expect(links[2].href).to eq '/1. one/2. two/'
        expect(links[3].label).to eq 'three'
        expect(links[3].href).to be_nil
      end
    end

    context 'when base_uri is set' do
      before { config.base_uri = '/docs' }
      after  { config.base_uri = nil }

      it 'prepends the links with the base_uri' do
        expect(links[1].href).to eq '/docs/one/'
        expect(links[2].href).to eq '/docs/one/two/'
        expect(links[3].href).to be_nil
      end
    end
  end
end
