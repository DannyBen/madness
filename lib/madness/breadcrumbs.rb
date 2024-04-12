module Madness
  # Handle breadcumbs generation by converting a path to an array
  # of links
  class Breadcrumbs
    using StringRefinements

    Breadcrumb = Struct.new :label, :href, keyword_init: true

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def links
      path == '' ? [] : breadcrumbs
    end

  private

    def breadcrumbs
      home = Breadcrumb.new label: 'Home', href: "#{config.base_uri}/"
      result = breadcrumbs_maker(path).reverse.unshift home
      result.last.href = nil
      result
    end

    def breadcrumbs_maker(partial_path)
      parent, basename = File.split partial_path
      href = "#{config.base_uri}/#{partial_path}"
      href = "#{href}/" unless href.end_with? '/'
      item = Breadcrumb.new label: basename.to_label, href: href
      result = [item]
      result += breadcrumbs_maker parent unless parent == '.'
      result
    end

    def config
      Settings.instance
    end
  end
end
