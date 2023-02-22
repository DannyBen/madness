module Madness
  # Handle breadcumbs generation by converting a path to an array
  # of links
  class Breadcrumbs
    using StringRefinements

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def links
      path == '' ? [] : breadcrumbs
    end

  private

    def breadcrumbs
      home = OpenStruct.new({ label: 'Home', href: "#{config.base_uri}/" })
      result = breadcrumbs_maker(path).reverse.unshift home
      result.last.last = true
      result
    end

    def breadcrumbs_maker(partial_path)
      parent, basename = File.split partial_path
      item = OpenStruct.new(
        {
          label: basename.to_label,
          href:  "#{config.base_uri}/#{partial_path}",
        }
      )
      result = [item]
      result += breadcrumbs_maker parent unless parent == '.'
      result
    end

    def config
      Settings.instance
    end
  end
end
