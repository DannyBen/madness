describe Commands::Theme do
  subject { described_class.new }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[theme --help] }.to output_approval('cli/theme/help')
    end
  end

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[theme] }.to output_approval('cli/theme/usage')
    end
  end

  context 'with full command' do
    let(:theme_dir) { 'tmp/theme-test' }

    before do
      system "rm -rf #{theme_dir}" if Dir.exist? theme_dir
      expect(Dir).not_to exist theme_dir
    end

    it 'copies the default theme to a folder of our choice' do
      expect { subject.execute "theme full #{theme_dir}" }.to output_approval('cli/theme/full-create')
      expect(Dir).to exist theme_dir
      expect(Dir["#{theme_dir}/**/*"].sort.to_yaml).to match_approval('cli/theme/theme-ls')
    end

    context 'when dir already exists' do
      before do
        system "mkdir #{theme_dir}" unless Dir.exist? theme_dir
      end

      it 'does not overwrite it' do
        expect { subject.execute "theme full #{theme_dir}" }.to raise_approval('cli/theme/theme-exists')
      end
    end
  end
end
