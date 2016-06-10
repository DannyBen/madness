
module Madness

  class Server < ServerBase
    get '/*' do
      path = params[:splat].first
      base = path.empty? ? docroot : "#{docroot}/#{path}"
      debug = nil

      if File.directory? base
        file = "#{base}/README.md"
        dir  = base
      elsif File.exist? "#{base}.md"
        file = "#{base}.md"
        dir  = File.dirname file
      else
        file = ''
        dir  = docroot
      end

      files = Dir["#{dir}/*.md"].map { |f| f.sub(/\.md$/, '') }
      files.reject! { |f| File.basename(f) == 'README' }

      dirs  = Dir["#{dir}/*"].select { |f| File.directory? f }

      nav = []
      dirs.sort.each do |item|
        nav.push OpenStruct.new({ label: File.basename(item).tr('-', ' '), href: item.sub(/^#{docroot}/, ''), type: 'd' })
      end

      files.sort.each do |item|
        nav.push OpenStruct.new({ label: File.basename(item).tr('-', ' '), href: item.sub(/^#{docroot}/, ''), type: 'f' })
      end

      if File.exist? file
        content = RDiscount.new(File.read file).to_html
      else
        content = ""
      end

      if path == ""
        breadcrumbs = []
      else
        breadcrumbs = get_breadcrumbs path
      end

      slim :document, locals: { 
        content: content, 
        nav: nav, 
        breadcrumbs: breadcrumbs,
        debug: debug 
      }
    end

    def get_breadcrumbs(path)
      home = OpenStruct.new({ label: "Home", path: '/' })
      # breadcrumbs_maker(path).drop(1).reverse.unshift home
      result = breadcrumbs_maker(path).reverse.unshift home
      result.last.last = true
      result
    end

    def breadcrumbs_maker(path)
      parent, basename = File.split path
      item = OpenStruct.new({ label: basename, path: "/#{path}" })
      result = [item]
      result += breadcrumbs_maker parent unless parent == '.'
      result
    end

  end
end