# Note that this spec gets a special treatement
# See the spec helper for details
describe Server, :standalone do
  before :all do
    config.reset
    config.path = 'spec/fixtures/base-uri'
    config.base_uri = '/docs'
  end

  describe '/' do
    it 'redirects to base_uri/' do
      get '/'
      expect(last_response).to be_redirection
      expect(last_response.location).to eq 'http://example.org/docs/'
    end
  end

  describe '/anything' do
    it 'redirects to base_uri/' do
      get '/anything'
      expect(last_response).to be_redirection
      expect(last_response.location).to eq 'http://example.org/docs/'
    end
  end

  describe '/docs' do
    it 'redirects to base_uri/' do
      get '/docs'
      expect(last_response).to be_redirection
      expect(last_response.location).to eq 'http://example.org/docs/'
    end
  end

  describe '/docs/Folder/File' do
    it 'is successful' do
      get '/docs/Folder/File'
      expect(last_response).to be_ok
      expect(last_response.body).to have_tag 'h1', text: 'Nested File #1'
    end
  end

  describe '/docs/main.css (internal file)' do
    it 'is successful' do
      get '/docs/css/main.css'
      expect(last_response.content_type).to eq 'text/css;charset=utf-8'
      expect(last_response.body).to match(/font-family/)
    end
  end

  # describe '/docs/custom.css (external file)' do
  #   it 'is successful' do    
  #     get '/docs/css/custom.css'
  #     expect(last_response.content_type).to eq 'text/css;charset=utf-8'
  #     expect(last_response.body).to match(/font-family/)
  #   end
  # end

  describe '/docs/Folder/bob.jpg' do
    it 'is successful' do
      get '/docs/Folder/bob.jpg'
      expect(last_response.content_type).to eq 'image/jpeg'
      expect(last_response.content_length).to eq 4369
    end
  end

  describe '/docs/_search' do
    it 'has a search form with the base_uri in the form action' do
      get '/docs/_search'
      expect(last_response).to be_ok
      expect(last_response.body).to have_tag 'form.search-form'
      expect(last_response.body).to have_tag :form, action: '/docs/_search'
    end
  end
end
