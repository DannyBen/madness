require 'spec_helper'

describe Item do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  context 'with a folder' do
    subject { described_class.new 'Folder/Subfolder', :dir }

    describe '#label' do
      it 'returns the basename' do
        expect(subject.label).to eq 'Subfolder'
      end

      context 'when the folder has a sorting marker' do
        subject { described_class.new 'Sorting/1. Y U NO SORT', :dir }

        it 'removes the sorting marker' do
          expect(subject.label).to eq 'Y U NO SORT'
        end
      end
    end

    describe '#href' do
      it 'returns link path' do
        expect(subject.href).to eq 'Folder/Subfolder'
      end
    end

    describe '#dir?' do
      it 'returns true' do
        expect(subject.dir?).to be true
      end
    end

    describe '#file?' do
      it 'returns false' do
        expect(subject.file?).to be false
      end
    end
  end

  context 'with a file' do
    subject { described_class.new 'Folder/File.md', :file }

    describe '#label' do
      it 'returns the basename' do
        expect(subject.label).to eq 'File'
      end

      context 'when the file has a sorting marker' do
        subject { described_class.new 'Sorting/1. X File', :file }

        it 'removes the sorting marker' do
          expect(subject.label).to eq 'X File'
        end
      end
    end

    describe '#href' do
      it 'returns link path' do
        expect(subject.href).to eq 'Folder/File'
      end
    end

    describe '#dir?' do
      it 'returns false' do
        expect(subject.dir?).to be false
      end
    end

    describe '#file?' do
      it 'returns true' do
        expect(subject.file?).to be true
      end
    end
  end
end
