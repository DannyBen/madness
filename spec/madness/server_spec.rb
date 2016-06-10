require 'spec_helper'

describe Server do

  let(:settings) { Settings.instance }

  before do 
    settings.reset
    settings.path = 'spec/fixtures/docroot'
  end

  it "works" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include "This is a docroot fixture"
  end

  context "in subfolders" do
    it "works" do
      get '/Folder'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Sub folder #1"
    end

    it "shows breadcrumbs" do
      get '/Folder'
      expect(last_response.body).to include '<div class="breadcrumbs">'
    end
  end

  context "with a nested file" do
    it "works" do
      get '/Folder/File'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Nested File #1"
    end

    it "shows breadcrumbs" do
      get '/Folder/File'
      expect(last_response.body).to include '<div class="breadcrumbs">'
    end
  end

  context "in an empty folder" do
    it "shows index" do
      get '/Empty+Folder'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Index"
    end
  end

  describe "sass plugin" do
    let(:css) { 'app/public/css/main.css' }

    it "generates css in the public folder" do
      File.unlink css if File.exist? css
      expect(File).not_to exist css
      sleep 1
      get '/css/main.css'
      expect(File).to exist css      
    end
  end

end