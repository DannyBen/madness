require 'spec_helper'

describe Directory do
  subject { described_class.new docroot }

  before do
    config.reset
    config.path = 'spec/fixtures/docroot/Sorting'
  end

  describe '#list' do
    it 'returns a naturally sorted array of Items' do
      list = subject.list

      expect(list).to be_an Array
      expect(list.count).to eq 6
      expect(list.first).to be_an Item
      expect(list.last.label).to eq 'Last File'
    end

    context 'when expose_extensions is set' do
      before do
        config.reset
        config.path = 'spec/fixtures/expose-extensions'
        config.expose_extensions = 'pdf,txt'
      end

      it 'also lists the files with the exposed extensions' do
        list = subject.list

        expect(list).to be_an Array
        expect(list.count).to eq 5
        expect(list.first).to be_an Item
        expect(list.first.label).to eq 'A dummy PDF file.pdf'
        expect(list.last.label).to eq 'Some dummy TXT file.txt'
      end
    end

    context 'when exclude is set' do
      before do
        config.reset
        config.path = 'spec/fixtures/exclude'
        config.exclude = %w[Ignore pub.ic]
      end

      it 'excludes directories based on the exclusion array' do
        list = subject.list

        expect(list).to be_an Array
        expect(list.count).to eq 2
        expect(list.first.label).to eq 'Folder'
        expect(list.last.label).to eq 'lowercase'
      end
    end
  end
end
