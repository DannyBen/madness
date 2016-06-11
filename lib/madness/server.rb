module Madness

  class Server < ServerBase
    get '/*' do
      path = params[:splat].first
      debug = nil

      doc = Document.new path
      file    = doc.file
      dir     = doc.dir
      content = doc.content

      nav = Navigation.new(dir).links
      breadcrumbs = Breadcrumbs.new(path).links

      slim :document, locals: { 
        content: content, 
        nav: nav, 
        breadcrumbs: breadcrumbs,
        debug: debug 
      }
    end

  end
end