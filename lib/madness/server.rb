require 'madness/server_base'

module Madness
  # The Sinatra server
  class Server < ServerBase
    using StringRefinements

    if config.base_uri
      not_found do
        redirect "#{config.base_uri}/"
      end

      get config.base_uri do
        redirect "#{config.base_uri}/"
      end
    end

    get "#{config.base_uri}/_search" do
      query = params[:q]
      results = query ? Search.new.search(query) : false
      nav = Navigation.new docroot
      slim :search, locals: {
        nav:     nav,
        results: results,
      }
    end

    get "#{config.base_uri}/*" do
      path = params[:splat].first
      static_file = find_static_file path

      next send_file static_file if static_file

      doc     = Document.new path
      dir     = doc.dir
      content = doc.content

      if (doc.type == :readme) && !path.empty? && (path[-1] != '/')
        redirect "#{request.path_info}/"
      end

      nav = Navigation.new dir
      breadcrumbs = Breadcrumbs.new(path).links

      if (nav.links.count == 1) && (doc.type == :empty)
        redirect to(nav.links.first.href)
      end

      status 404 if doc.type == :missing

      source_link = nil
      if config.source_link && %i[file readme].include?(doc.type)
        source_link = {
          uri:      config.source_link % { path: doc.href },
          label:    config.source_link_label,
          position: config.source_link_pos,
        }
      end

      slim :document, locals: {
        content:     content,
        type:        doc.type,
        title:       doc.title,
        file:        doc.file,
        nav:         nav,
        breadcrumbs: breadcrumbs,
        source_link: source_link,
      }
    end
  end
end
