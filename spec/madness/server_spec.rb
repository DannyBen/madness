require 'spec_helper'

describe Server do
  before do
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  it 'serves properly' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to have_tag 'h1', text: 'This is a docroot fixture'
  end

  it 'serves css' do
    get '/css/main.css'
    expect(last_response.content_type).to eq 'text/css;charset=utf-8'
    expect(last_response.body).to match(/font-family/)
  end

  describe 'get /_search' do
    before do
      config.reset
      config.path = 'spec/fixtures/search'
    end

    context 'without a query' do
      it 'has a search form' do
        get '/_search'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'form.search-form'
      end
    end

    context 'with a query' do
      it 'has a search form' do
        get '/_search?q=luke'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'form.search-form'
      end

      it 'has results' do
        get '/_search?q=luke'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'a', text: '7 The Force Awakens'
      end
    end
  end

  describe 'get /*' do
    it 'serves static files' do
      get '/ok.png'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'image/png'
      expect(last_response.content_length).to eq 1167
    end

    context 'when requesting an invalid page' do
      it 'shows index' do
        get '/no-such-page'
        expect(last_response).to be_not_found
        expect(last_response.body).to have_tag 'h1', text: 'Index'
      end
    end

    context 'when requesting a subfolder' do
      it 'shows its index' do
        get '/Folder/'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: 'Sub folder #1'
      end

      it 'redirects to have a trailing slash' do
        get '/Folder'
        expect(last_response).to be_redirection
        expect(last_response.location).to eq 'http://example.org/Folder/'
      end

      it 'redirects to a properly encoded path' do
        get '/Folder%20with%20Index'
        expect(last_response).to be_redirection
        expect(last_response.location).to eq 'http://example.org/Folder%20with%20Index/'
      end

      it 'shows breadcrumbs' do
        get '/Folder/'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'span', text: 'Folder'
        end
      end

      it 'serves static files' do
        get '/Folder/bob.jpg'
        expect(last_response).to be_ok
        expect(last_response.content_type).to eq 'image/jpeg'
        expect(last_response.content_length).to eq 4369
      end
    end

    context 'with a nested file' do
      it 'serves the file' do
        get '/Folder/File'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: 'Nested File #1'
      end

      it 'shows breadcrumbs' do
        get '/Folder/File'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'a', text: 'Folder'
          with_tag 'span', text: 'File'
        end
      end
    end

    context 'with a nested file with .md extension' do
      it 'serves the file' do
        get '/Folder/File.md'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: 'Nested File #1'
      end

      it 'shows breadcrumbs' do
        get '/Folder/File.md'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'a', text: 'Folder'
          with_tag 'span', text: 'File'
        end
      end
    end

    context 'when the folder is empty' do
      it 'shows index' do
        get '/Empty%20Folder'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: /Empty Folder/
      end
    end

    context 'when the folder contains a single file' do
      it 'redirects to the file' do
        get '/Redirect'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.url).to match(%r{Redirect/The%20only%20file%20here})
      end

      it 'does not redirect if the file is README' do
        get '/No%20Redirect/'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'p', text: 'Was not redirected'
      end
    end

    context 'when basic authentication is enabled' do
      before { config.auth = 'user:s3cr3t' }

      it 'denies access' do
        get '/'
        expect(last_response).to be_unauthorized
      end

      context 'with proper credentials' do
        it 'allows access' do
          authorize 'user', 's3cr3t'
          get '/'
          expect(last_response).to be_ok
        end
      end
    end
  end
end
