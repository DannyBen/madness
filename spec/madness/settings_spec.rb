require 'spec_helper'

describe Settings do
  before do
    config.reset
  end

  it "sets default values" do
    expect(config.port).to eq 3000
    expect(config.bind).to eq '0.0.0.0'
    expect(config.path).to eq '.'
  end

  context "with a config file" do
    before do
      allow(config).to receive(:filename).and_return('spec/fixtures/.madness.yml')
      config.reset
    end

    it "overrides config values" do
      expect(config.path).to eq 'to/enlightenment'
      expect(config.port).to eq '1337'
      expect(config.bind).to eq '4.3.2.1'
      expect(config.auto_h1).to be false
      expect(config.highlighter).to be false
      expect(config.line_numbers).to be false
      expect(config.index).to be true
      expect(config.open).to be false
      expect(config.auth).to eq 'user:s3cr3t'
      expect(config.auth_realm).to eq 'Madness'
    end
  end

end