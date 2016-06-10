require 'spec_helper'

describe CommandLine do
  let(:cli) { Madness::CommandLine.clone.instance }

  describe '#execute' do
    context "without arguments" do
      it "runs with the current folder as docroot" do
        expect(Server).to receive :run!
        expect {cli.execute}.to output(/start.*the madness/).to_stdout
      end
    end

    context "with valid arguments" do
      it "accepts port and address argument" do
        expect(Server).to receive :run!
        command = %w[-b 8.8.8.8 -p 1234]
        expect {cli.execute command}.to output(/listen.*8.8.8.8:1234/).to_stdout
      end
    end

    context "with invalid arguments" do
      it "shows usage" do
        expect(Server).not_to receive :run!
        command = %w[--no --such --args]
        expect {cli.execute command}.to output(/--no is not recognized\nUsage:/).to_stdout
      end
    end

    context "with an existing folder" do
      it "uses the folder as docroot" do
        expect(Server).to receive :run!
        command = %w[spec/fixtures/docroot]
        expected = %r[path.*spec/fixtures/docroot]
        expect {cli.execute command}.to output(expected).to_stdout
      end
    end

    context "with a non existing folder" do
      it "shows an error message" do
        expect(Server).not_to receive :run!
        command = %w[no_such_folder]
        expect {cli.execute command}.to output(/Invalid path/).to_stdout
      end
    end

  end
end