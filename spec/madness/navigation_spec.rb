require 'spec_helper'

describe Navigation do
  before do
    config.reset
    config.path ='spec/fixtures/nav'
  end  

  subject { described_class.new docroot }

  describe '#links' do
    it "sets an array of links" do
      expect(subject.links).to be_an Array
    end

    it "sets proper link properties for folders" do
      link = subject.links.first
      
      expect(link.label).to eq 'Folder'
      expect(link.href).to eq '/Folder'
      expect(link.type).to eq :dir
    end

    it "sets proper link properties for files" do
      link = subject.links.last
      
      expect(link.label).to eq 'XFile'
      expect(link.href).to eq '/XFile'
      expect(link.type).to eq :file
    end

    it "omits _folders" do
      result = subject.links.select { |f| f.label[0] == '_' }
      expect(result.count).to eq 0
    end
  end

  describe '#caption' do
    context "at docroot" do
      it "sets caption to 'Index'" do
        expect(subject.caption).to eq "Index"
      end
    end

    context "when docroot is provided" do
      subject { described_class.new "#{docroot}/Folder" }
      
      it "sets a caption" do
        expect(subject.caption).to eq 'Folder'
      end
    end
  end
end