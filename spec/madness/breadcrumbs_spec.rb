require 'spec_helper'

describe Breadcrumbs do
  subject { described_class.new('one/two/three') }

  describe '#links' do
    let(:links) { subject.links }

    it 'adds returns an array of OpenStructs' do
      expect(links).to be_an Array
      expect(links.count).to eq 4
      expect(links.first).to be_an OpenStruct
    end

    it 'adds a home link' do
      expect(links.first.label).to eq 'Home'
      expect(links.first.href).to eq '/'
    end

    it 'adds a link to each element' do
      expect(links[1].label).to eq 'one'
      expect(links[1].href).to eq '/one'
      expect(links[2].label).to eq 'two'
      expect(links[2].href).to eq '/one/two'
      expect(links[3].label).to eq 'three'
      expect(links[3].href).to eq '/one/two/three'
    end

    it 'adds a last attribute to last element' do
      expect(links.last.last).to be true
    end

    context 'with sorted elements' do
      subject { described_class.new('1. one/2. two/3. three') }

      it 'removes sorting markers from labels' do
        expect(links[1].label).to eq 'one'
        expect(links[1].href).to eq '/1. one'
        expect(links[2].label).to eq 'two'
        expect(links[2].href).to eq '/1. one/2. two'
        expect(links[3].label).to eq 'three'
        expect(links[3].href).to eq '/1. one/2. two/3. three'
      end
    end
  end
end
