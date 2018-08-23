require 'spec_helper'

describe HashRefinements do
  using HashRefinements

  describe '#symbolize_keys' do
    subject { { 'key': 'value' , 'another': 'pair' } }

    it "converts keys to symbols" do
      expect(subject.symbolize_keys).to eq({key: 'value', another: 'pair'})
    end    
  end
end