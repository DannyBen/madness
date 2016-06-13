require 'madness/server_base'

module Madness

  # The Sinatra server
  class Server < ServerBase
    get '/*' do
      path = params[:splat].first

      doc = Document.new path
      dir     = doc.dir
      content = doc.content

      nav = Navigation.new(dir)
      breadcrumbs = Breadcrumbs.new(path).links

      if nav.links.count == 1 and doc.type == :empty
        redirect to(nav.links.first.href)
      end

      slim :document, locals: { 
        content: content, 
        type: doc.type,
        title: doc.title,
        nav: nav, 
        breadcrumbs: breadcrumbs
      }
    end
  end
end