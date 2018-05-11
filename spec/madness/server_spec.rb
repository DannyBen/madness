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

  describe 'get /*.dot' do
    context "in production mode" do
      before do 
        config.reset
        config.path = 'spec/fixtures/dot'
        config.development = false
      end

      it "redirects to the respective png image" do
        get '/sample1.dot'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq '/sample1.png'
      end

      it "does not create the png image" do
        filename = 'spec/fixtures/dot/public/sample1.png' 
        File.delete filename if File.exist? filename

        get '/sample1.dot'
        expect(last_response).to be_redirect
        expect(File).not_to exist filename
      end
    end

    context "in development mode" do
      before do 
        config.reset
        config.path = 'spec/fixtures/dot'
        config.development = true
      end

      it "redirects to the respective png image" do
        get '/sample1.dot'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq '/sample1.png'
      end

      it "creates a png image in the public folder" do
        filename = 'spec/fixtures/dot/public/sample1.png'

        File.delete filename if File.exist? filename
        expect(File).not_to exist filename
        get '/sample1.dot'

        expect(File).to exist filename
      end

      context "with subfolders" do
        it "redirects to the respective png image" do
          get '/diagrams/sample1.dot'
          expect(last_response).to be_redirect
          follow_redirect!
          expect(last_request.path).to eq '/diagrams/sample1.png'
        end

        it "creates a png image in a subfolder " do
          dir = "spec/fixtures/dot/public/diagrams"
          filename = "#{dir}/sample2.png"

          FileUtils.rm_rf dir if Dir.exist? dir
          expect(Dir).not_to exist dir

          get '/diagrams/sample2.dot'

          expect(File).to exist filename
        end        
      end

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
        get '/Folder'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'h1', text: "Sub folder #1"
      end

      it "shows breadcrumbs" do
        get '/Folder'
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
        get '/No%20Redirect'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag 'p', text: "Was not redirected"
      end
    end

  end

end