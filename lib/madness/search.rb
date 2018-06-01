module Madness

  class Search
    include ServerHelper
    include Ferret
    include Ferret::Index
    using StringRefinements

    def initialize(path=nil)
      @path = path || docroot
    end

    def has_index?
      Dir.exist? index_dir
    end

    def build_index
      Dir.mkdir index_dir unless Dir.exist? index_dir

      index = Index.new path: index_dir, create: true

      Dir["#{@path}/**/*.md"].each do |file|
        index << { file: file, content: searchable_content(file) }
      end

      index.optimize()                                
      index.close()
    end

    def search(query)
      index = Index.new path: index_dir

      results = []
      index.search_each(query, limit: 20) do |doc_id, score| 
        filename = index[doc_id][:file].sub("#{@path}/", '')[0...-3]
        highlights = index.highlight "content:(#{query.tr(' ',' OR ')}) ", doc_id, field: :content,
          pre_tag: "<strong>", post_tag: "</strong>",
          excerpt_length: 100
        
        results << { 
          score: score, 
          file: filename,
          label: file_label(filename),
          highlights: highlights
        }
      end

      index.close()
      results
    end

    def remove_index_dir
      return unless Dir.exist? index_dir
      FileUtils.rm_r index_dir
    end

    def index_dir
      "#{@path}/_index"
    end

    private

    # This is poor-mans markdown strip.
    # Convert to HTML, strip tags and return plain text suitable to act as
    # the content for the search index.
    def searchable_content(file)
      content = File.read file
      content = CommonMarker.render_html content
      content.gsub(/<\/?[^>]*>/, "").gsub("\n", " ")
    end

    def file_label(filename)
      filename.split('/').map(&:to_label).join(' / ')
    end
  end
end
