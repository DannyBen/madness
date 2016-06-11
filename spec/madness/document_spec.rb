require 'spec_helper'

describe Document do
  let(:config) { Settings.instance }

  before do
    config.reset
    config.path ='spec/fixtures/docroot'
  end  

  describe '#initialize' do
    context "with empty path" do
      let(:doc) { Document.new "" }

      it "sets docroot as base dir" do
        expect(doc.dir).to match /#{config.path}$/
      end

      it "uses the README" do
        expect(doc.file).to include "README.md"
      end
    end

    context "with a directory" do
      let(:doc) { Document.new "Folder" }

      it "sets docroot as base dir" do
        expect(doc.dir).to match /#{config.path}\/Folder$/
      end

      it "uses the README" do
        expect(doc.file).to include "README.md"
      end
    end

    context "with a file" do
      let(:doc) { Document.new "File" }

      it "adds md extension" do
        expect(doc.file).to match /File.md$/
      end
    end

    context "with an invalid file" do
      let(:doc) { Document.new "Y U NO FILE" }

      it "sets an empty content" do
        expect(doc.content).to be_empty
      end
    end
  end

  describe '#content' do
    it "adds h1 automatically" do
      doc = Document.new "File without H1"
      expect(doc.content).to include "<h1>File without H1</h1>"
    end

    context "with auto h1 disabled" do
      it "does not add h1" do
        config.autoh1 = false
        doc = Document.new "File without H1"
        expect(doc.content).not_to include "<h1>"
      end
    end
  end
end