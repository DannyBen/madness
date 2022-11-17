module Madness
  # Generate a markdown Table of Contents
  class TableOfContents
    include ServerHelper

    attr_reader :dir

    def initialize(dir = nil)
      @dir = dir || docroot
    end

    def build(file)
      file += '.md' unless file.end_with? '.md'
      File.write "#{dir}/#{file}", toc
    end

    def toc
      @toc ||= toc!.join("\n")
    end

  private

    def toc!(path = dir, indent = 0)
      list = Directory.new(path).list

      result = []
      list.each do |item|
        case item.type
        when :dir
          result.push "#{' ' * indent}1. #{make_link item}"
          result += toc! item.path, indent + 4
        when :file
          result.push "#{' ' * indent}1. #{make_link item}"
        end
      end
      result
    end

    def make_link(item)
      "[#{item.label}](#{item.href})"
    end
  end
end
