require 'spec_helper'

describe Browser do
  subject { described_class.new host, 3456 }

  let(:host) { '127.0.0.1' }

  describe '#server_url' do
    it 'returns a url string' do
      expect(subject.server_url).to eq 'http://localhost:3456'
    end

    context 'when host is 0.0.0.0' do
      it "converts it to 'localhost'" do
        expect(subject.server_url).to eq 'http://localhost:3456'
      end
    end

    context 'when host is not a localhost address' do
      let(:host) { '1.2.3.4' }

      it 'returns it as is' do
        expect(subject.server_url).to eq 'http://1.2.3.4:3456'
      end
    end
  end

  describe '#server_running?' do
    let(:mock_socket) { Class.new { def close; end }.new }

    it 'attempts to connect several times and returns true on success' do
      expect(Socket).to receive(:tcp).with(subject.host, subject.port).and_raise 'cannot connect'
      expect(Socket).to receive(:tcp).with(subject.host, subject.port).and_return mock_socket
      expect(subject.server_running?).to be true
    end

    context 'when it fails to connect' do
      it 'returns false' do
        expect(Socket).to receive(:tcp).with(subject.host, subject.port).and_return false
        expect(subject.server_running?).to be false
      end
    end
  end

  describe '#open' do
    context 'when the server is not running' do
      it 'yields an error message' do
        expect(subject).to receive(:fork) do |&block|
          expect(subject).to receive(:server_running?).and_return false
          block.call
        end

        expect do |b|
          subject.open(&b)
        end.to yield_with_args('Failed connecting to http://localhost:3456. Is the server running?')
      end
    end

    context 'when the server is running but the launch command fails' do
      it 'yields an error message' do
        expect(subject).to receive(:fork) do |&block|
          expect(subject).to receive(:server_running?).and_return true
          expect(subject).to receive(:open!).and_return false
          block.call
        end

        regexp = Regexp.new 'Failed opening browser (.*open http://localhost:3456)'
        expect { |b| subject.open(&b) }.to yield_with_args(regexp)
      end
    end

    context 'when the server is running and the launch command succeeds' do
      it 'yields nil' do
        expect(subject).to receive(:fork) do |&block|
          expect(subject).to receive(:server_running?).and_return true
          expect(subject).to receive(:open!).and_return true
          block.call
        end

        expect { |b| subject.open(&b) }.to yield_with_args(nil)
      end
    end
  end

  describe '#open!' do
    it "runs the system command that opens the browser ('xdg-open' on linux, 'open' on OSX)" do
      expect(subject).to receive(:system).with(/(xdg-)?open/, subject.server_url, anything)
      subject.open!
    end
  end

  describe '#open_command' do
    it 'returns a command in array form' do
      open_cmd, server_url = subject.open_command
      expect(open_cmd).to match(/(xdg-)?open/)
      expect(server_url).to eq subject.server_url
    end
  end
end
