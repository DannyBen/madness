describe Navigation do
  subject { described_class.new docroot }

  before do
    config.reset
    config.path = 'spec/fixtures/nav'
  end

  describe '#links' do
    it 'returns an array of links' do
      expect(subject.links).to be_an Array
    end

    it 'returns the array sorted alphabetically, directories first' do
      expect(subject.links.map(&:label)).to eq [
        'Folder', 'Folder-Dash', 'Folder Space',
        'File-Dash', 'File Space', 'XFile'
      ]
    end

    it 'sets proper link properties for folders' do
      link = subject.links.first

      expect(link.label).to eq 'Folder'
      expect(link.href).to eq '/Folder'
      expect(link.type).to eq :dir
    end

    it 'sets proper link properties for files' do
      link = subject.links.last

      expect(link.label).to eq 'XFile'
      expect(link.href).to eq '/XFile'
      expect(link.type).to eq :file
    end

    it 'omits _folders' do
      result = subject.links.select { |f| f.label[0] == '_' }
      expect(result.count).to eq 0
    end

    context 'when config.sort_order = mixed' do
      before { config.sort_order = 'mixed' }

      it 'returns the array sorted alphabetically regardless of type' do
        expect(subject.links.map(&:label)).to eq [
          'File Space', 'File-Dash', 'Folder',
          'Folder Space', 'Folder-Dash', 'XFile'
        ]
      end
    end

    context 'when config.sort_order = mixed and with numbered items' do
      before do
        config.sort_order = 'mixed'
        config.path = 'spec/fixtures/nav-sorted'
      end

      it 'returns the array sorted alphabetically while obeying numeric markers' do
        expect(subject.links.map(&:label)).to eq [
          'Introduction', 'Getting Started', 'Getting Help', 'Legal'
        ]
      end
    end
  end

  describe '#caption' do
    context 'with docroot' do
      it "sets caption to 'Index'" do
        expect(subject.caption).to eq 'Index'
      end
    end

    context 'with an inner folder' do
      subject { described_class.new "#{docroot}/Folder" }

      it 'sets a caption' do
        expect(subject.caption).to eq 'Folder'
      end
    end

    context 'with an inner folder and a sorting marker' do
      subject { described_class.new "#{docroot}/Sorting/2. A Folder" }

      it 'sets a caption without the marker' do
        expect(subject.caption).to eq 'A Folder'
      end
    end
  end
end
