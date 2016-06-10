require 'spec_helper'

describe Server do

  it "works" do
    get '/'
    expect(last_response).to be_ok
  end

  context "in subfolders" do
    it "shows breadcrumbs" do
      get '/Folder'
      expect(last_response).to be_ok
      expect(last_response.body).to include '<div class="breadcrumbs">'
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