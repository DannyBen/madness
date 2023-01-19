describe 'bin/madness' do
  subject { CLI.runner }

  it 'shows list of commands' do
    expect { subject.run }.to output_approval('cli/bin/commands')
  end

  context 'when an error occurs' do
    it 'displays it nicely' do
      expect(`bin/madness theme full /no/such/path 2>&1`).to match_approval('cli/bin/error')
    end
  end
end
