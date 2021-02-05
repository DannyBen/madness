require 'spec_helper'

describe Directory do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot/Sorting'
  end

  subject { described_class.new docroot }

  describe '#list' do

    it "returns a naturally sorted array of Items" do
      list = subject.list

      expect(list).to be_an Array
      expect(list.count).to eq 6
      expect(list.first).to be_an Item
      expect(list.last.label).to eq "Last File"
    end
    
    context "when expose_extensions is set" do
      before do
        config.reset
        config.path = 'spec/fixtures/expose-extensions'
        config.expose_extensions = "pdf,txt"
      end

      it "also lists the files with the exposed extensions" do
        list = subject.list

        expect(list).to be_an Array
        expect(list.count).to eq 5
        expect(list.first).to be_an Item
        expect(list.first.label).to eq "A dummy PDF file.pdf"        
        expect(list.last.label).to eq "Some dummy TXT file.txt"
      end
    end
  end


end