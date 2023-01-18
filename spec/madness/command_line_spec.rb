require 'spec_helper'

describe CommandLine do
  subject { described_class.clone.instance }

  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  context 'without arguments' do
    it 'runs with the current folder as docroot' do
      expect(Server).to receive :run!
      expect { subject.execute }.to output(/start.*the madness/).to_stdout
    end
  end

  context 'with --help' do
    it 'shows help' do
      expect(Server).not_to receive :run!
      command = %w[--help]
      expect { subject.execute command }.to output_approval('cli/help')
    end
  end

  context 'with valid arguments' do
    it 'accepts port and address argument' do
      expect(Server).to receive :run!
      command = %w[-b 8.8.8.8 -p 1234]
      expect { subject.execute command }.to output(/listen.*8.8.8.8:1234/).to_stdout
    end
  end

  context 'with invalid arguments' do
    it 'shows usage' do
      expect(Server).not_to receive :run!
      command = %w[--no-such-args]
      expect { subject.execute command }.to output_approval('cli/usage')
    end
  end

  context 'with an existing folder' do
    it 'uses the folder as docroot' do
      expect(Server).to receive :run!
      command = %w[spec/fixtures/docroot]
      expected = %r{path.*spec/fixtures/docroot}
      expect { subject.execute command }.to output(expected).to_stdout
    end
  end

  context 'with a non existing folder' do
    it 'shows an error message' do
      expect(Server).not_to receive :run!
      command = %w[no_such_folder]
      expect { subject.execute command }.to output(/Invalid path/).to_stderr_from_any_process
    end
  end

  context 'with --toc' do
    let(:toc_double) { instance_double TableOfContents, build: nil }

    it 'calls the TOC builder' do
      expect(Server).to receive :run!
      expect(TableOfContents).to receive(:new).and_return(toc_double)
      command = %w[--toc Contents.md]
      expect { subject.execute command }.to output(/toc.*generating Contents.md.*start.*the madness/m).to_stdout
    end
  end

  context 'with --open' do
    let(:browser_double) { instance_double Browser, open: false }

    it 'calls Browser#open' do
      expect(Server).to receive :run!
      allow(Browser).to receive(:new).and_return(browser_double)
      expect(browser_double).to receive(:open).and_return false
      command = %w[--open]
      expect { subject.execute command }.to output(/start.*the madnes/m).to_stdout
    end

    context 'when browser launching fails' do
      it 'shows a friendly message' do
        expect(Server).to receive :run!
        expect(Browser).to receive(:new).and_return(browser_double)
        expect(browser_double).to receive(:open).and_yield 'this is a friendly message'
        command = %w[--open]
        expect { subject.execute command }.to output(/friendly message/m).to_stdout
      end
    end
  end

  context 'with create config' do
    let(:filename) { '.madness.yml' }

    it 'creates a new config file' do
      Dir.chdir 'tmp' do
        system "rm #{filename}" if File.exist? filename
        expect(File).not_to exist filename

        expect { subject.execute 'create config' }.to output(/Created #{filename}/).to_stdout
        expect(File).to exist filename
      end

      expect(File.read "tmp/#{filename}").to eq File.read('lib/madness/templates/madness.yml')
    end

    context 'when file already exists' do
      it 'does not overwrite it' do
        Dir.chdir 'tmp' do
          system "touch #{filename}" unless File.exist? filename
          expect { subject.execute 'create config' }
            .to output(/Abort: config file #{filename} already exists/)
            .to_stdout
        end
      end
    end
  end

  context 'with create theme' do
    let(:theme_dir) { 'tmp/theme-test' }

    before do
      system "rm -rf #{theme_dir}" if Dir.exist? theme_dir
      expect(Dir).not_to exist theme_dir
    end

    it 'copies the default theme to a folder of our choice' do
      expect { subject.execute "create theme #{theme_dir}" }.to output(/Created #{theme_dir}/).to_stdout
      expect(Dir).to exist theme_dir
      expect(Dir["#{theme_dir}/**/*"].sort.to_yaml).to match_approval('cli/theme-ls')
    end

    context 'when dir already exists' do
      before do
        system "mkdir #{theme_dir}" unless Dir.exist? theme_dir
      end

      it 'does not overwrite it' do
        expect { subject.execute "create theme #{theme_dir}" }
          .to output(/Abort: folder #{theme_dir} already exists/)
          .to_stdout
      end
    end
  end

  context 'when executed in a folder with .madness.yml' do
    before { config.reset }

    it 'does considers the config values' do
      expect(Server).to receive :run!

      Dir.chdir 'spec/fixtures/docroot-with-config' do
        expect { subject.execute }
          .to output_approval('cli/run-with-config')
          .except(%r{/.*/})
      end
    end
  end
end
