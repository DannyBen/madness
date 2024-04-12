describe InlineTableOfContents do
  subject { described_class.new markdown }

  let(:markdown) { File.read 'spec/fixtures/docroot/File with TOC and Code.md' }

  describe '#markdown' do
    it 'returns a markdown table of contents' do
      expect(subject.markdown).to match_approval('inline-toc')
    end
  end
end
