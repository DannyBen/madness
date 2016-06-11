require 'spec_helper'

describe Settings do
  before do
    config.reset
  end

  it "sets default values" do
    expect(config.port).to eq '3000'
    expect(config.bind).to eq '0.0.0.0'
    expect(config.path).to eq '.'
  end

end