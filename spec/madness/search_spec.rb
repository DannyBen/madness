require 'spec_helper'
require 'fileutils'

describe Search do
  let(:search) { described_class.new 'spec/fixtures/search' }

  before do 
    search.build_index unless search.has_index?
  end

  describe '#has_index?' do
    it "returns false when there is no index" do
      search.remove_index_dir
      expect(search).not_to have_index
    end

    it "returns true when there is an index" do
      search.build_index
      expect(search).to have_index
    end
  end

  describe '#build_index' do
    context "where both README.md and index.md are present" do
      it "does not index README.md" do
        results = search.search 'benedict'
        expect(results.count).to eq 1
        expect(results.first[:file]).to eq "Twins"
      end
    end

    context "when index does not exist" do
      before do
        search.remove_index_dir
        expect(search).not_to have_index
      end

      it "builds" do
        search.build_index
        expect(search).to have_index
      end
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

    it "escapes HTML and highlights search term" do
      result = search.search('Turmoil Galactic Republic').first
      excerpt = result[:highlights][1]
      expect(excerpt).to eq "...planet of Naboo. While the Congress of the <strong>Republic</strong> endlessly debates this alarming chain of events..."
    end

    it "removes sorting markers from file labels" do
      result = search.search('x files').first
      expect(result[:label]).to eq 'I Do Not Belong'
    end

    it "removes trailing /README and /index from files" do
      results = search.search('ruby').map { |r| r[:file] }
      expect(results.sort).to eq ["With README", "With index"]
    end

    it "removes trailing /README and /index from labels" do
      results = search.search('ruby').map { |r| r[:label] }
      expect(results.sort).to eq ["With README", "With index"]
    end
  end

end