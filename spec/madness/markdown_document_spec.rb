describe MarkdownDocument do
  subject { described_class.new markdown, title: title }

  let(:title) { 'Spec Document Title' }
  let(:markdown) { File.read "spec/fixtures/docroot/#{file}.md" }
  let(:file) { 'Extras' }

  before do
    config.reset
    config.auto_h1 = false
    config.shortlinks = false
    config.auto_toc = false
    config.highlighter = false
  end

  describe '#to_html' do
    let(:file) { 'Style Guide/All' }

    it 'renders properly' do
      expect(subject.to_html).to match_approval('render/all-disabled')
    end

    context 'when there are headings with diacritics' do
      let(:file) { 'Diacritics' }

      before { config.auto_toc = true }

      it 'renders properly with matching href IDs' do
        expect(subject.to_html).to match_approval('render/diacritics')
      end
    end

    context 'when all options are enabled' do
      before do
        config.auto_h1 = true
        config.shortlinks = true
        config.auto_toc = true
        config.highlighter = true
      end

      it 'renders properly' do
        expect(subject.to_html).to match_approval('render/all-enabled')
      end
    end

    context 'with pandoc renderer' do
      before do
        config.renderer = 'pandoc'
        config.highlighter = true
      end

      it 'renders properly' do
        expect(subject.to_html).to match_approval('render/pandoc')
      end
    end
  end

  describe '#text' do
    it 'returns the markdown text as is' do
      expect(subject.text).to eq markdown
    end

    context 'when auto_h1 is enabled' do
      before { config.auto_h1 = true }

      context 'when the file has H1' do
        let(:file) { 'File' }

        it 'does not add an H1 header' do
          expect(subject.text).to eq markdown
        end
      end

      context 'when the file has H1 with alt syntax' do
        let(:file) { 'File with H1 alt' }

        it 'does not add an H1 header' do
          expect(subject.text).to eq markdown
        end
      end

      context 'when the file does not have H1' do
        let(:file) { 'File without H1' }

        it 'adds an H1 header' do
          expect(subject.text).to start_with "# #{title}"
        end
      end
    end

    context 'when shortlinks is enabled' do
      before { config.shortlinks = true }

      it 'converts shortlinks to links' do
        expect(subject.text).to include '[CHANGELOG](CHANGELOG)'
        expect(subject.text).not_to include '[[CHANGELOG]]'
      end
    end

    context 'when auto_toc is enabled' do
      before { config.auto_toc = true }

      it 'replaces the TOC marker with a table of contents' do
        expect(subject.text).to include '- [List](#list)'
        expect(subject.text).not_to include '<!-- TOC -->'
      end
    end

    context 'when auto_toc is a string' do
      before { config.auto_toc = caption }

      let(:caption) { '### Custom Contents Caption' }

      it 'replaces the TOC marker and applies the requested caption' do
        expect(subject.text).to include caption
        expect(subject.text).to include '- [List](#list)'
        expect(subject.text).not_to include '<!-- TOC -->'
      end
    end
  end
end
