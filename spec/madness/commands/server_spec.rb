describe Commands::Server do
  subject { described_class.new }

  let(:server) { Madness::Server }

  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[server --help] }.to output_approval('cli/server/help')
    end
  end

  context 'without arguments' do
    it 'runs with the current folder as docroot' do
      expect(server).to receive :run!
      expect { subject.execute %w[server] }.to output(/starting server/).to_stdout
    end
  end

  context 'with invalid arguments' do
    it 'shows usage' do
      expect(server).not_to receive :run!
      command = %w[--no-such-args]
      expect { subject.execute command }.to output_approval('cli/server/usage')
    end
  end

  context 'with valid bind and port arguments' do
    it 'starts the server with the requested arguments' do
      expect(server).to receive :run!
      expect { subject.execute %w[server -b 8.8.8.8 -p 1234] }
        .to output(/listen.*8.8.8.8:1234/).to_stdout
    end
  end

  context 'with an existing folder' do
    it 'uses the folder as docroot' do
      expect(server).to receive :run!
      expect { subject.execute %w[server spec/fixtures/docroot] }
        .to output(%r{path.*spec/fixtures/docroot}).to_stdout
    end
  end

  context 'with a non existing folder' do
    it 'shows an error message' do
      expect(server).not_to receive :run!
      expect { subject.execute %w[server no_such_folder] }
        .to raise_approval('cli/server/no-such-folder')
    end
  end

  context 'with --open' do
    let(:browser_double) { instance_double Madness::Browser, open: false }

    it 'calls Browser#open' do
      expect(server).to receive :run!
      allow(Madness::Browser).to receive(:new).and_return(browser_double)
      expect(browser_double).to receive(:open).and_return false
      expect { subject.execute %w[server --open] }.to output(/starting server/).to_stdout
    end

    context 'when browser launching fails' do
      it 'shows a friendly message' do
        expect(server).to receive :run!
        expect(Madness::Browser).to receive(:new).and_return(browser_double)
        expect(browser_double).to receive(:open).and_yield 'this is a friendly message'
        expect { subject.execute %w[server --open] }.to output(/friendly message/m).to_stdout
      end
    end
  end

  context 'when executed in a folder with .madness.yml' do
    before { config.reset }

    it 'does considers the config values' do
      expect(server).to receive :run!

      Dir.chdir 'spec/fixtures/docroot-with-config' do
        expect { subject.execute %w[server] }
          .to output_approval('cli/server/run-with-config')
          .except(%r{/.*/})
      end
    end
  end

  context 'when executed in a toc configured' do
    before { config.reset }

    let(:toc_double) { instance_double TableOfContents, build: nil }

    it 'calls the TOC builder' do
      expect(server).to receive :run!

      Dir.chdir 'spec/fixtures/docroot-with-config' do
        expect(TableOfContents).to receive(:new).and_return(toc_double)
        expect { subject.execute %w[server] }
          .to output(/generating Table of Contents/)
          .to_stdout
      end
    end
  end
end
