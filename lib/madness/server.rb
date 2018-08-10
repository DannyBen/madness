require 'madness/server_base'

module Madness

  # The Sinatra server
  class Server < ServerBase
    get '/_search' do
      query = params[:q]
      results = query ? Search.new.search(query) : false
      nav = Navigation.new docroot
      slim :search, locals: {
        nav: nav,
        results: results
      }
    end

    get '/_search/autocomplete' do
      query = params[:query]
      return { suggestions: [] } if query.empty?

      results = Search.new.search query
      suggestions = results.map { |r| { value: r[:label], data: r[:file] } }
      
      response = { suggestions: suggestions }
      response.to_json
    end

    get '/*' do
      path = params[:splat].first

      doc     = Document.new path
      dir     = doc.dir
      content = doc.content

      if doc.type == :readme and !path.empty? and path[-1] != '/'
        redirect "#{path}/"
      end

      nav = Navigation.new dir
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