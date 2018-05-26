require 'spec_helper'

describe Document do
  before do
    config.reset
    config.path ='spec/fixtures/docroot'
  end  

  describe '#initialize' do
    context "with empty path" do
      subject { described_class.new "" }

      it "sets docroot as base dir" do
        expect(subject.dir).to match(/#{config.path}$/)
      end

      it "uses the README" do
        expect(subject.file).to include "README.md"
      end
    end

    context "with a directory" do
      subject { described_class.new "Folder" }

      it "sets docroot as base dir" do
        expect(subject.dir).to match(/#{config.path}\/Folder$/)
      end

      it "uses the README" do
        expect(subject.file).to include "README.md"
      end
    end

    context "with a file" do
      subject { described_class.new "File" }

      it "adds md extension" do
        expect(subject.file).to match(/File.md$/)
      end
    end

    context "with an invalid file" do
      subject { described_class.new "Y U NO FILE" }

      it "sets an empty content" do
        expect(subject.content).to be_empty
      end
    end
  end

  describe '#content' do
    it "adds h1 automatically to files" do
      doc = described_class.new "File without H1"
      expect(doc.content).to have_tag :h1, text: "File without H1"
    end

    it "adds h1 automatically to folders" do
      doc = described_class.new "Folder without H1"
      expect(doc.content).to have_tag :h1, text: "Folder without H1"
    end

    it "syntax highlights code" do
      doc = described_class.new "Code"
      expect(doc.content).to include 'class="CodeRay"'
    end

    it "does not double escape html" do
      doc = described_class.new "Double Escape"
      expect(doc.content).to include ' &gt; '
      expect(doc.content).not_to include ' &amp; '
    end

    it "adds anchors to headers" do
      doc = described_class.new "File"
      expect(doc.content).to have_tag :a, id: 'just-a-file'
    end

    context "with auto h1 disabled" do
      it "does not add h1" do
        config.auto_h1 = false
        doc = described_class.new "File without H1"
        expect(doc.content).not_to have_tag :h1
      end
    end
  end

end
