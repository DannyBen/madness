require 'spec_helper'

describe StringRefinements do
  using StringRefinements

  subject { "String with !23@  " }

  describe '#to_slug' do
    it "converts string to slug" do
      expect(subject.to_slug).to eq 'string-with-23'
    end
  end

end