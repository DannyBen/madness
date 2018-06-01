require 'spec_helper'

describe Directory do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot/Sorting'
  end

  subject { described_class.new docroot }

  describe '#list' do
    let(:list) { subject.list }

    it "returns a naturally sorted array of Items" do
      expect(list).to be_an Array
      expect(list.count).to eq 6
      expect(list.first).to be_an Item
      expect(list.last.label).to eq "Last File"
    end
  end
end