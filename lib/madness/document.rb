module Madness
  # Handle a single document path.
  class Document
    include ServerHelper
    using StringRefinements

    attr_reader :base, :path, :type, :file, :dir, :title

    def initialize(path)
      @path = path
      @base = path.empty? ? docroot : "#{docroot}/#{path}"
      @base.chomp! '/'
      set_base_attributes
    end

    # Return the HTML for that document
    def content
      @content ||= %i[empty missing].include?(type) ? "<h1>#{title}</h1>" : markdown.to_html
    end

    def relative_file
      file[%r{^#{docroot}/(.*)}, 1]
    end

    def href
      relative_file.to_href
    end

  private

    # Identify file, dir and type.
    # :readme  - in case the path is a directory, and it contains index.md,
    #            readme.md, or README.md
    # :file    - in case the path is a *.md file
    # :empty   - in case it is a folder without README.md or index.md
    # :missing - in any other case, we don't know (will trigger 404)
    def set_base_attributes
      @dir  = docroot
      @type = :missing
      @file = ''
      @title = 'Index'

      if File.directory? base
        @title = File.basename(path).to_label unless path.empty?
        set_base_attributes_for_directory
      elsif md_file?
        @file = md_filename
        @title = File.basename(base).to_label
        @dir  = File.dirname file
        @type = :file
      end
    end

    def set_base_attributes_for_directory
      @dir  = base
      @type = :readme

      if cover_page
        @file = cover_page
      else
        @type = :empty
      end
    end

    def markdown
      @markdown ||= MarkdownDocument.new(markdown_text, title: title)
    end

    def markdown_text
      @markdown_text ||= File.read file
    end

    def md_file?
      File.exist?("#{base}.md") || (File.exist?(base) && File.extname(base) == '.md')
    end

    def md_filename
      File.extname(base) == '.md' ? base : "#{base}.md"
    end

    def cover_page
      @cover_page ||= cover_page!
    end

    def cover_page!
      cover_page_candidates.each do |candidate|
        return candidate if File.exist? candidate
      end

      nil
    end

    def cover_page_candidates
      @cover_page_candidates ||= [
        File.expand_path("../#{File.basename(base)}.md", base),
        File.expand_path('index.md', base),
        File.expand_path('README.md', base),
        File.expand_path('readme.md', base),
      ]
    end
  end
end
