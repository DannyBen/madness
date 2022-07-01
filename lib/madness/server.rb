require 'madness/server_base'

module Madness

  # The Sinatra server
  class Server < ServerBase
    using StringRefinements

    get '/_search' do
      query = params[:q]
      results = query ? Search.new.search(query) : false
      nav = Navigation.new docroot
      slim :search, locals: {
        nav: nav,
        results: results
      }
    end

    get '/*' do
      path = params[:splat].first

      doc     = Document.new path
      dir     = doc.dir
      content = doc.content

      if doc.type == :readme and !path.empty? and path[-1] != '/'
        redirect "#{path.to_href}/"
      end

      nav = Navigation.new dir
      breadcrumbs = Breadcrumbs.new(path).links

      if nav.links.count == 1 and doc.type == :empty
        redirect to(nav.links.first.href)
      end

      status 404 if doc.type == :missing

      slim :document, locals: { 
        content: content, 
        type: doc.type,
        title: doc.title,
        file: doc.file,
        nav: nav, 
        breadcrumbs: breadcrumbs
      }
    end
  end
end