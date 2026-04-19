describe Madness::Middleware::LiveReload do
  let(:inner_app) { double('app') }
  let(:middleware) { described_class.new(inner_app) }

  describe '#call' do
    context 'when the request is a websocket upgrade to /_live_reload' do
      it 'delegates to LiveReload.handle' do
        env = { 'PATH_INFO' => '/_live_reload' }
        rack_response = [200, {}, []]

        allow(Madness::LiveReload).to receive(:websocket?).with(env).and_return(true)
        expect(Madness::LiveReload).to receive(:handle).with(env).and_return(rack_response)

        result = middleware.call(env)
        expect(result).to eq(rack_response)
      end
    end

    context 'when the request is a websocket but wrong path' do
      it 'passes through to the app' do
        env = { 'PATH_INFO' => '/other' }
        app_response = [200, {}, ['ok']]

        allow(Madness::LiveReload).to receive(:websocket?).with(env).and_return(true)
        expect(inner_app).to receive(:call).with(env).and_return(app_response)

        result = middleware.call(env)
        expect(result).to eq(app_response)
      end
    end

    context 'when the request is not a websocket' do
      it 'passes through to the app' do
        env = { 'PATH_INFO' => '/_live_reload' }
        app_response = [200, {}, ['ok']]

        allow(Madness::LiveReload).to receive(:websocket?).with(env).and_return(false)
        expect(inner_app).to receive(:call).with(env).and_return(app_response)

        result = middleware.call(env)
        expect(result).to eq(app_response)
      end
    end

    context 'when the path has a base_uri prefix' do
      it 'matches /_live_reload at the end' do
        env = { 'PATH_INFO' => '/docs/_live_reload' }
        rack_response = [200, {}, []]

        allow(Madness::LiveReload).to receive(:websocket?).with(env).and_return(true)
        expect(Madness::LiveReload).to receive(:handle).with(env).and_return(rack_response)

        result = middleware.call(env)
        expect(result).to eq(rack_response)
      end
    end
  end
end
