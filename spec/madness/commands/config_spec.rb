describe Commands::Config do
  subject { described_class.new }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[config --help] }.to output_approval('cli/config/help')
    end
  end

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[config] }.to output_approval('cli/config/usage')
    end
  end

  context 'with new command' do
    let(:filename) { '.madness.yml' }

    it 'creates a new config file' do
      Dir.chdir 'tmp' do
        system "rm #{filename}" if File.exist? filename
        expect(File).not_to exist filename

        expect { subject.execute 'config new' }.to output(/Created #{filename}/).to_stdout
        expect(File).to exist filename
      end

      expect(File.read "tmp/#{filename}").to eq File.read('lib/madness/templates/madness.yml')
    end

    context 'when file already exists' do
      it 'does not overwrite it' do
        Dir.chdir 'tmp' do
          system "touch #{filename}" unless File.exist? filename
          expect { subject.execute 'config new' }.to raise_approval('cli/config/new-error')
        end
      end
    end
  end
end
