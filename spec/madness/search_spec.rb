require 'spec_helper'
require 'fileutils'

describe Search do
  let(:search) { described_class.new 'spec/fixtures/search' }

  describe '#has_index?' do
    it "returns false when there is no index" do
      search.remove_index_dir
      expect(search.has_index?).to be false
    end

    it "returns true when there is an index" do
      search.build_index
      expect(search.has_index?).to be true
    end
  end

  describe '#build_index' do
    before do
      search.remove_index_dir
    end

    it "builds" do
      search.build_index
      expect(search.has_index?).to be true      
    end
  end

  describe '#search' do
    it "finds" do
      results = search.search 'luke skywalker'
      expect(results).to be_an Array
      expect(results.count).to eq 3
    end

    it "returns a result hash" do
      result = search.search('luke skywalker').first
      expect(result[:score]).to be_a Float
      expect(result[:file]).to eq "7 The Force Awakens"
      expect(result[:label]).to be_a String
      expect(result[:highlights]).to be_an Array
    end

    it "escapes HTML" do
      result = search.search('Turmoil Galactic Republic').first
      excerpt = result[:highlights][1]
      expect(excerpt).not_to include ">"
      expect(excerpt).to include "&gt;"
    end
  end

end