module Madness

  class Search
    include ServerHelper
    include Ferret
    include Ferret::Index

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
        index << { file: file, content: File.read(file) }
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
          pre_tag: "", post_tag: "",
          excerpt_length: 100
        
        highlights.map! { |excerpt| CGI.escapeHTML excerpt } if highlights

        results << { 
          score: score, 
          file: filename,
          label: filename.gsub("/", " / "),
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

  end
end
