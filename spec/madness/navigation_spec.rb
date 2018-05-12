require 'spec_helper'

describe Navigation do
  before do
    config.reset
    config.path ='spec/fixtures/nav'
  end  

  let(:nav) { Navigation.new docroot }

  describe '#links' do
    it "sets an array of links" do
      expect(nav.links).to be_an Array
    end

    it "sets proper link properties for folders" do
      subject = nav.links.first
      
      expect(subject.label).to eq 'Folder'
      expect(subject.href).to eq '/Folder'
      expect(subject.type).to eq :dir
    end

    it "sets proper link properties for files" do
      subject = nav.links.last
      
      expect(subject.label).to eq 'XFile'
      expect(subject.href).to eq '/XFile'
      expect(subject.type).to eq :file
    end

    it "omits _folders" do
      result = nav.links.select { |f| f.label[0] == '_' }
      expect(result.count).to eq 0
    end
  end

  describe '#caption' do
    context "at docroot" do
      it "sets caption to 'Index'" do
        expect(nav.caption).to eq "Index"
      end
    end

    context "when docroot is provided" do
      let(:nav) { Navigation.new "#{docroot}/Folder" }
      
      it "sets a caption" do
        expect(nav.caption).to eq 'Folder'
      end
    end
  end
end