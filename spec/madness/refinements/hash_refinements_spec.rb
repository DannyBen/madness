require 'spec_helper'

describe HashRefinements do
  using described_class
  subject { { 'key' => 'value', 'another' => 'pair' } }

  describe '#symbolize_keys' do
    it 'converts keys to symbols' do
      expect(subject.symbolize_keys).to eq({ key: 'value', another: 'pair' })
    end

    it 'does not alter the original hash' do
      subject.symbolize_keys
      expect(subject).to eq({ 'key' => 'value', 'another' => 'pair' })
    end
  end

  describe '#symbolize_keys!' do
    it 'alters the original hash' do
      subject.symbolize_keys!
      expect(subject).to eq({ key: 'value', another: 'pair' })
    end
  end
end
