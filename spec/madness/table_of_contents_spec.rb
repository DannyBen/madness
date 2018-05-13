require 'spec_helper'

describe TableOfContents do
  before do 
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  describe '#toc' do
    it "returns a markdown table of contents" do
      expect(subject.toc).to match_fixture('toc')
    end
  end

  describe '#build' do
    it "saves table of contents to a file" do
      filename = /spec\/fixtures\/docroot\/Contents.md/
      content = subject.toc
      expect(File).to receive(:write).with(filename, content)
      subject.build 'Contents'
    end
  end

end