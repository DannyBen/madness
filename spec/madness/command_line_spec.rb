require 'spec_helper'

describe CommandLine do
  subject { described_class.clone.instance }

  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  describe '#execute' do
    context "without arguments" do
      it "runs with the current folder as docroot" do
        expect(Server).to receive :run!
        expect { subject.execute }.to output(/start.*the madness/).to_stdout
      end
    end

    context "with --help" do
      it "shows help" do
        expect(Server).not_to receive :run!
        command = %w[--help]
        expect { subject.execute command }.to output_fixture('cli/help')
      end
    end

    context "with valid arguments" do
      it "accepts port and address argument" do
        expect(Server).to receive :run!
        command = %w[-b 8.8.8.8 -p 1234]
        expect { subject.execute command}.to output(/listen.*8.8.8.8:1234/).to_stdout
      end
    end

    context "with invalid arguments" do
      it "shows usage" do
        expect(Server).not_to receive :run!
        command = %w[--no-such-args]
        expect { subject.execute command }.to output_fixture('cli/usage')
      end
    end

    context "with an existing folder" do
      it "uses the folder as docroot" do
        expect(Server).to receive :run!
        command = %w[spec/fixtures/docroot]
        expected = %r[path.*spec/fixtures/docroot]
        expect { subject.execute command }.to output(expected).to_stdout
      end
    end

    context "with a non existing folder" do
      it "shows an error message" do
        expect(Server).not_to receive :run!
        command = %w[no_such_folder]
        expect { subject.execute command }.to output(/Invalid path/).to_stderr_from_any_process
      end
    end

    context "with --index" do
      it "calls the index builder and starts the server" do
        expect(Server).to receive :run!
        expect_any_instance_of(Search).to receive :build_index
        command = %w[--index]
        expect { subject.execute command }.to output(/index.*generating.*start.*the madness/m).to_stdout
      end
    end

    context "with --index --and-quit" do
      it "calls the index builder" do
        expect_any_instance_of(Search).to receive :build_index
        command = %w[--index --and-quit]
        expect { subject.execute command }.to output(/index.*generating/).to_stdout
      end
    end

    context "with --toc" do
      it "calls the TOC builder" do
        expect(Server).to receive :run!
        expect_any_instance_of(TableOfContents).to receive :build
        command = %w[--toc Contents.md]
        expect { subject.execute command }.to output(/toc.*generating Contents.md.*start.*the madness/m).to_stdout
      end
    end

  end
end