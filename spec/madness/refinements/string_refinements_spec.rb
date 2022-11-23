require 'spec_helper'

describe StringRefinements do
  using described_class

  describe '#remove' do
    subject { 'not an excellent example' }

    it 'removes the matching pattern' do
      expect(subject.remove(/^not | excellent/)).to eq 'an example'
    end
  end

  describe '#to_slug' do
    subject { 'String with !23@  ' }

    it 'converts string to slug' do
      expect(subject.to_slug).to eq 'string-with-23'
    end
  end

  describe '#label' do
    context 'when a string starts with numbers followed by a dot' do
      subject { '99. Red Baloons' }

      it 'removes the digits' do
        expect(subject.to_label).to eq 'Red Baloons'
      end
    end

    context 'when a string starts with numbers but no dot' do
      subject { '99 Red Baloons' }

      it 'does not remove the digits' do
        expect(subject.to_label).to eq '99 Red Baloons'
      end
    end
  end

  describe '#to_href' do
    subject { 'Disney Land/Space Mountain' }

    it 'converts the string to a valid URI' do
      expect(subject.to_href).to eq 'Disney%20Land/Space%20Mountain'
    end
  end
end
