module Madness
  class Breadcrumbs
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def links
      path == "" ? [] : get_breadcrumbs
    end

    private

    def get_breadcrumbs
      home = OpenStruct.new({ label: "Home", href: '/' })
      result = breadcrumbs_maker(path).reverse.unshift home
      result.last.last = true
      result
    end

    def breadcrumbs_maker(partial_path)
      parent, basename = File.split partial_path
      item = OpenStruct.new({ 
        label: basename.tr('-', ' '), 
        href: "/#{partial_path}" }
      )
      result = [item]
      result += breadcrumbs_maker parent unless parent == '.'
      result
    end
  end
end