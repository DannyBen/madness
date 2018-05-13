require 'spec_helper'

describe Directory do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  subject { described_class.new docroot }

  describe '#list' do
    it "returns an array of Items" do
      expect(subject.list).to be_an Array
      expect(subject.list.count).to eq 12
      expect(subject.list.first).to be_an Item
    end
  end
end