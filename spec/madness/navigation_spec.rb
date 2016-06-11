require 'spec_helper'

describe Navigation do
  before do
    config.reset
    config.path ='spec/fixtures/nav'
  end  

  describe '#initialize' do
    let(:nav) { Navigation.new docroot }

    context "at docroot" do
      it "does not set caption" do
        expect(nav.caption).to be nil
      end
    end

    context "at deeper folder" do
      let(:nav) { Navigation.new "#{docroot}/Folder" }
      
      it "sets a caption" do
        expect(nav.caption).to eq 'Folder'
      end
    end

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
   
  end
end