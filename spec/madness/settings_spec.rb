require 'spec_helper'

describe Settings do
  before { config.reset }

  it 'sets default values' do
    expect(config.port).to eq 3000
    expect(config.bind).to eq '0.0.0.0'
    expect(config.path).to eq '.'
  end

  context 'with a config file' do
    before do
      allow(config).to receive(:filename).and_return('spec/fixtures/.madness.yml')
      config.reset
    end

    it 'overrides config values' do
      expect(config.path).to eq 'to/enlightenment'
      expect(config.port).to eq '1337'
      expect(config.bind).to eq '4.3.2.1'
      expect(config.auto_h1).to be false
      expect(config.highlighter).to be false
      expect(config.line_numbers).to be false
      expect(config.open).to be false
      expect(config.auth).to eq 'user:s3cr3t'
      expect(config.auth_realm).to eq 'Madness'
    end
  end

  context 'with an empty (fully commented out) config file' do
    before do
      allow(config).to receive(:filename).and_return('spec/fixtures/.empty-madness.yml')
      config.reset
    end

    it 'sets the default values' do
      expect(config.port).to eq 3000
    end
  end

  describe '#respond_to?' do
    it 'returns true always' do
      expect(config.respond_to? :anything).to be true
    end
  end
end
