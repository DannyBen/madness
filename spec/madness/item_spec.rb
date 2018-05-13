require 'spec_helper'

describe Item do
  before do
    config.reset
    config.path ='spec/fixtures/docroot'
  end  

  context "with a folder" do
    subject { described_class.new 'Folder/Subfolder', :dir }

    describe '#label' do
      it "returns the basename" do
        expect(subject.label).to eq "Subfolder"
      end
    end

    describe '#href' do
      it "returns link path" do
        expect(subject.href).to eq "Folder/Subfolder"
      end
    end

    describe '#dir?' do
      it "returns true" do
        expect(subject.dir?).to be true
      end
    end

    describe '#file?' do
      it "returns false" do
        expect(subject.file?).to be false
      end
    end
  end

  context "with a file" do
    subject { described_class.new 'Folder/File.md', :file }

    describe '#label' do
      it "returns the basename" do
        expect(subject.label).to eq "File"
      end
    end

    describe '#href' do
      it "returns link path" do
        expect(subject.href).to eq "Folder/File"
      end
    end

    describe '#dir?' do
      it "returns false" do
        expect(subject.dir?).to be false
      end
    end

    describe '#file?' do
      it "returns true" do
        expect(subject.file?).to be true
      end
    end
  end
end