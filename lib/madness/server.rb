module Madness

  class Server < ServerBase
    get '/*' do
      path = params[:splat].first
      debug = nil

      doc = Document.new path
      dir     = doc.dir
      content = doc.content

      nav = Navigation.new(dir)
      breadcrumbs = Breadcrumbs.new(path).links

      slim :document, locals: { 
        content: content, 
        type: doc.type,
        nav: nav, 
        breadcrumbs: breadcrumbs,
        debug: debug 
      }
    end

  end
end