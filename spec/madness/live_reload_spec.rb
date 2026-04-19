describe LiveReload do
  before do
    described_class.instance_variable_set(:@clients, [])
    described_class.instance_variable_set(:@listener, nil)
  end

  after do
    described_class.instance_variable_set(:@listener, nil)
    described_class.instance_variable_set(:@clients, [])
  end

  describe '.watch' do
    it 'starts a listener on the given path' do
      listener = double('listener', start: true)
      expect(Listen).to receive(:to).with('/some/path').and_return(listener)
      expect(listener).to receive(:start)

      described_class.watch('/some/path')
    end
  end

  describe '.stop' do
    it 'stops the listener' do
      listener = double('listener')
      described_class.instance_variable_set(:@listener, listener)
      expect(listener).to receive(:stop)

      described_class.stop
    end

    it 'does nothing when no listener exists' do
      described_class.instance_variable_set(:@listener, nil)
      expect { described_class.stop }.not_to raise_error
    end
  end

  describe '.add_client' do
    it 'adds the websocket to the clients list' do
      ws = double('ws')
      allow(ws).to receive(:on)

      described_class.add_client(ws)

      clients = described_class.instance_variable_get(:@clients)
      expect(clients).to include(ws)
    end

    it 'registers a close handler that removes the client' do
      ws = double('ws')
      close_handler = nil
      allow(ws).to receive(:on).with(:close) { |&block| close_handler = block }

      described_class.add_client(ws)
      close_handler.call

      clients = described_class.instance_variable_get(:@clients)
      expect(clients).not_to include(ws)
    end
  end

  describe '.broadcast' do
    it 'sends joined filenames to all clients' do
      ws_one = double('ws1')
      ws_two = double('ws2')
      allow(ws_one).to receive(:on)
      allow(ws_two).to receive(:on)

      described_class.add_client(ws_one)
      described_class.add_client(ws_two)

      expect(ws_one).to receive(:send).with('a.md,b.md')
      expect(ws_two).to receive(:send).with('a.md,b.md')

      described_class.broadcast(['a.md', 'b.md'])
    end
  end

  describe '.websocket?' do
    it 'delegates to Faye::WebSocket' do
      env = { 'HTTP_UPGRADE' => 'websocket' }
      expect(Faye::WebSocket).to receive(:websocket?).with(env).and_return(true)
      expect(described_class.websocket?(env)).to be true
    end
  end

  describe '.handle' do
    it 'creates a websocket, adds it as client, and returns rack response' do
      env = {}
      ws = double('ws')
      rack_response = [200, {}, []]

      expect(Faye::WebSocket).to receive(:new).with(env).and_return(ws)
      allow(ws).to receive(:on)
      expect(ws).to receive(:rack_response).and_return(rack_response)

      result = described_class.handle(env)
      expect(result).to eq(rack_response)
    end
  end

  describe 'on_change (via watch callback)' do
    it 'broadcasts deduplicated file list and logs changes' do
      listener = double('listener')
      callback = nil
      allow(Listen).to receive(:to) { |_path, &block| callback = block; listener }
      allow(listener).to receive(:start)

      described_class.watch('/path')

      ws = double('ws')
      allow(ws).to receive(:on)
      described_class.add_client(ws)

      expect(ws).to receive(:send).with('/path/file.md')
      expect($stderr).to receive(:puts).with('LiveReload: /path/file.md')

      callback.call(['/path/file.md'], [], [])
    end

    it 'merges modified, added, and removed files' do
      listener = double('listener')
      callback = nil
      allow(Listen).to receive(:to) { |_path, &block| callback = block; listener }
      allow(listener).to receive(:start)

      described_class.watch('/path')

      ws = double('ws')
      allow(ws).to receive(:on)
      described_class.add_client(ws)

      expect(ws).to receive(:send).with('mod.md,add.md,del.md')
      allow($stderr).to receive(:puts)

      callback.call(['mod.md'], ['add.md'], ['del.md'])
    end
  end
end
