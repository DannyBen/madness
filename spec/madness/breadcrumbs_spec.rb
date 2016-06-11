require 'spec_helper'

describe Breadcrumbs do
  describe '#links' do
    let(:links) { Breadcrumbs.new("one/two/three").links }
    
    it "adds returns an array of OpenStructs" do
      expect(links).to be_an Array
      expect(links.first).to be_an OpenStruct
    end

    it "adds a home link" do
      expect(links.first.label).to eq "Home"
      expect(links.first.href).to eq "/"
    end

    it "adds a link to each element" do
      expect(links[1].label).to eq "one"
      expect(links[1].href).to eq "/one"
      expect(links[2].label).to eq "two"
      expect(links[2].href).to eq "/one/two"
      expect(links[3].label).to eq "three"
      expect(links[3].href).to eq "/one/two/three"
    end

    it "adds a last attribute to last element" do
      expect(links.last.last).to be true
    end

  end
end