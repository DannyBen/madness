require 'spec_helper'

describe Server do
  before do 
    config.reset
    config.path = 'spec/fixtures/docroot'
  end

  it "works" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to have_tag 'h1', text: "This is a docroot fixture"
  end

  describe 'get /_search' do
    before do 
      config.reset
      config.path = 'spec/fixtures/search'
    end

    context "without a query" do
      it "has a search form" do
        get '/_search'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'form.search-form'
      end
    end

    context "with a query" do
      it "has a search form" do
        get '/_search?q=luke'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'form.search-form'
      end

      it "has results" do
        get '/_search?q=luke'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'a', text: "7 The Force Awakens"
      end
    end
  end

  describe 'get /_search/autocomplete' do
    before do 
      config.reset
      config.path = 'spec/fixtures/search'
    end

    it "returns json formatted suggestions" do
      get '/_search/autocomplete?query=luke'
      expect(last_response).to be_ok
      actual = JSON.parse(last_response.body)['suggestions']
      expect(actual.count).to eq 3
      expect(actual[2]).to include "The Empire Strikes Back"
    end

  end

  describe 'get /*' do
    it "serves static files" do
      get '/ok.png'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq "image/png"
      expect(last_response.content_length).to eq 1167
    end

    context "in subfolders" do
      it "works" do
        get '/Folder/'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: "Sub folder #1"
      end

      it "redirects to have a trailing slash" do
        get '/Folder'
        expect(last_response).to be_redirection
        expect(last_response.location).to eq 'http://example.org/Folder/'
      end

      it "shows breadcrumbs" do
        get '/Folder/'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'span', text: 'Folder'
        end
      end

      it "serves static files" do
        get '/Folder/bob.jpg'
        expect(last_response).to be_ok
        expect(last_response.content_type).to eq "image/jpeg"
        expect(last_response.content_length).to eq 4369
      end
    end

    context "with a nested file" do
      it "works" do
        get '/Folder/File'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: "Nested File #1"
      end

      it "shows breadcrumbs" do
        get '/Folder/File'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'a', text: 'Folder'
          with_tag 'span', text: 'File'
        end
      end
    end

    context "with a nested file with .md extension" do
      it "works" do
        get '/Folder/File.md'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: "Nested File #1"
      end

      it "shows breadcrumbs" do
        get '/Folder/File.md'
        expect(last_response.body).to have_tag '.breadcrumbs' do
          with_tag 'a', text: 'Home'
          with_tag 'a', text: 'Folder'
          with_tag 'span', text: 'File'
        end
      end
    end

    context "in an empty folder" do
      it "shows index" do
        get '/Empty%20Folder'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: /Empty Folder/
      end
    end

    context "in a folder with a single file" do
      it "redirects to the file" do
        get '/Redirect'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.url).to match(/Redirect\/The%20only%20file%20here/)
      end

      it "does not redirect if the file is README" do
        get '/No%20Redirect/'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'p', text: "Was not redirected"
      end
    end

  end

end