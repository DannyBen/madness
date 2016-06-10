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

end