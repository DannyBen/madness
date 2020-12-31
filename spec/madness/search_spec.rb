require 'spec_helper'
require 'fileutils'

describe Search do
  let(:search) { described_class.new 'spec/fixtures/search' }

  describe '#index' do
    context "where both README.md and index.md are present" do
      it "does not index README.md" do
        results = search.search 'benedict'
        expect(results.count).to eq 1
        expect(results.keys.first).to eq "Twins"
      end
    end
  end

  describe '#search' do
    it "finds" do
      results = search.search 'luke skywalker'
      expect(results).to be_a Hash
      expect(results.count).to eq 3
    end

    it "returns a result hash" do
      result = search.search('luke skywalker')
      expect(result.keys.first).to eq "5 The Empire Strikes Back"
      expect(result.values.first).to be_a String
    end

    it "removes trailing /README and /index from files" do
      results = search.search('ruby').keys
      expect(results.sort).to eq ["With README", "With index"]
    end
  end

end