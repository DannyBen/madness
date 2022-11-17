require 'spec_helper'

describe Theme do
  context 'when a path is provided' do
    subject { described_class.new 'spec/fixtures/sample-theme' }

    describe '#views_path' do
      it 'returns the correct path' do
        expect(subject.views_path).to eq 'spec/fixtures/sample-theme/views'
      end
    end

    describe '#public_path' do
      it 'returns the correct path' do
        expect(subject.public_path).to eq 'spec/fixtures/sample-theme/public'
      end
    end
  end

  context 'when no path is provided' do
    subject { described_class.new }

    describe '#views_path' do
      it 'returns the default path' do
        expect(subject.views_path).to match %r{madness/app/views$}
      end
    end

    describe '#public_path' do
      it 'returns the default path' do
        expect(subject.public_path).to match %r{madness/app/public$}
      end
    end
  end
end
