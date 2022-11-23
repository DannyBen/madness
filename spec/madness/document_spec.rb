require 'spec_helper'

describe Document do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  describe 'base attributes' do
    context 'with a directory that contains an index.md' do
      subject { described_class.new 'Folder with Index' }

      describe '#type' do
        it 'returns :readme' do
          expect(subject.type).to eq :readme
        end
      end

      describe '#file' do
        it 'returns full path to file' do
          expect(subject.file).to end_with 'Folder with Index/index.md'
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with 'Folder with Index'
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'Folder with Index'
        end
      end
    end

    context 'with a directory that contains a README.md' do
      subject { described_class.new 'Folder' }

      describe '#type' do
        it 'returns :readme' do
          expect(subject.type).to eq :readme
        end
      end

      describe '#file' do
        it 'returns full path to file' do
          expect(subject.file).to end_with 'Folder/README.md'
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with 'Folder'
        end

        it 'sets docroot as base dir' do
          expect(subject.dir).to match(%r{#{config.path}/Folder$})
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'Folder'
        end
      end
    end

    context 'with a directory that does not contain valid index file' do
      subject { described_class.new 'Empty Folder' }

      describe '#type' do
        it 'returns :empty' do
          expect(subject.type).to eq :empty
        end
      end

      describe '#file' do
        it 'returns empty string' do
          expect(subject.file).to eq ''
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with "#{config.path}/Empty Folder"
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'Empty Folder'
        end
      end
    end

    context 'with a file' do
      subject { described_class.new 'Folder/File' }

      describe '#type' do
        it 'returns :file' do
          expect(subject.type).to eq :file
        end
      end

      describe '#file' do
        it 'returns full path to file' do
          expect(subject.file).to end_with 'Folder/File.md'
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with "#{config.path}/Folder"
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'File'
        end
      end
    end

    context 'with a file.md' do
      subject { described_class.new 'Folder/File.md' }

      describe '#type' do
        it 'returns :file' do
          expect(subject.type).to eq :file
        end
      end

      describe '#file' do
        it 'returns full path to file' do
          expect(subject.file).to end_with 'Folder/File.md'
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with "#{config.path}/Folder"
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'File'
        end
      end
    end

    context 'with an empty path when a README is present' do
      subject { described_class.new '' }

      describe '#type' do
        it 'returns :readme' do
          expect(subject.type).to eq :readme
        end
      end

      describe '#file' do
        it 'returns full path to file' do
          expect(subject.file).to end_with "#{config.path}/README.md"
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with config.path
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'Index'
        end
      end
    end

    context 'with an empty path when a README is not present' do
      subject { described_class.new '' }

      before do
        config.reset
        config.path = 'spec/fixtures/docroot/Empty Folder'
      end

      describe '#type' do
        it 'returns :empty' do
          expect(subject.type).to eq :empty
        end
      end

      describe '#file' do
        it 'returns empty string' do
          expect(subject.file).to eq ''
        end
      end

      describe '#dir' do
        it 'returns full path to directory' do
          expect(subject.dir).to end_with config.path
        end
      end

      describe '#title' do
        it 'returns proper title' do
          expect(subject.title).to eq 'Index'
        end
      end
    end

    context 'with a document that has a sorting marker' do
      subject { described_class.new 'Sorting/1. Y U NO SORT' }

      it 'removes the markers' do
        expect(subject.title).to eq 'Y U NO SORT'
      end
    end
  end

  describe '#content' do
    it 'adds h1 automatically to files' do
      doc = described_class.new 'File without H1'
      expect(doc.content).to have_tag :h1, text: 'File without H1'
    end

    it 'adds h1 automatically to folders' do
      doc = described_class.new 'Folder without H1'
      expect(doc.content).to have_tag :h1, text: 'Folder without H1'
    end

    it 'syntax highlights code' do
      doc = described_class.new 'Code'
      expect(doc.content).to include 'class="CodeRay"'
    end

    it 'does not double escape html' do
      doc = described_class.new 'Double Escape'
      expect(doc.content).to include ' &gt; '
      expect(doc.content).not_to include ' &amp; '
    end

    it 'adds anchors to headers' do
      doc = described_class.new 'File'
      expect(doc.content).to have_tag :a, id: 'just-a-file'
    end

    it 'replaces <!-- TOC --> markers with table of contents' do
      doc = described_class.new 'File with TOC'
      expect(doc.content).to match_approval 'document-toc'
    end

    context 'when headers contain links' do
      subject { described_class.new 'CHANGELOG' }

      it 'does not does not break' do
        expect { subject.content }.not_to raise_error
      end
    end

    context 'with an invalid file' do
      subject { described_class.new 'Y U NO FILE' }

      it 'sets H1' do
        expect(subject.content).to eq '<h1>Index</h1>'
      end
    end

    context 'with auto h1 disabled' do
      it 'does not add h1' do
        config.auto_h1 = false
        doc = described_class.new 'File without H1'
        expect(doc.content).not_to have_tag :h1
      end
    end

    context 'with shortlinks enabled' do
      it 'evaluates shortlinks' do
        config.shortlinks = true
        doc = described_class.new 'File with Shortlink'
        expect(doc.content).to have_tag(:a, with: { href: 'Shortlink' }, text: 'Shortlink')
      end
    end
  end
end
