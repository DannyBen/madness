require 'spec_helper'
require 'fileutils'

describe Search do
  subject { described_class.new path }
  let(:path) { 'spec/fixtures/search' }

  describe '#index' do
    context "where both README.md and index.md are present" do
      it "does not index README.md" do
        results = subject.search 'benedict'
        expect(results.count).to eq 1
        expect(results.keys.first).to eq "Twins"
      end
    end
  end

  describe '#search' do
    it "finds" do
      results = subject.search 'luke skywalker'
      expect(results).to be_a Hash
      expect(results.count).to eq 3
    end

    it "returns a result hash" do
      result = subject.search('luke skywalker')
      expect(result.keys.first).to eq "5 The Empire Strikes Back"
      expect(result.values.first).to be_a String
    end

    it "removes trailing /README and /index from files" do
      results = subject.search('ruby').keys
      expect(results.sort).to eq ["With README", "With index"]
    end

    it "removes the sorting prefixes from the labels" do
      results = subject.search('file').keys
      expect(results).to eq ["With Sorting / File 1", "With Sorting / File 2", "I Do Not Belong"]
    end

    context "with a quoted query" do
      it "returns only pages that include the exact phrase" do
        expect(subject.search('the jedi').count).to be > 1
        expect(subject.search('"the jedi"').count).to eq 1
      end
    end
  end

end