module Madness

  class Search
    include ServerHelper
    include Ferret
    include Ferret::Index

    def has_index?
      Dir.exist? index_dir
    end

    def build_index
      Dir.mkdir index_dir unless Dir.exist? index_dir

      index = Index.new path: index_dir, create: true

      Dir["#{docroot}/**/*.md"].each do |file|
        index << { file: file, content: File.read(file) }
      end

      index.optimize()                                
      index.close()
    end

    def search(query)
      index = Index.new path: index_dir

      results = []
      total_hits = index.search_each(query, limit: 20) do |doc_id, score| 
        filename = index[doc_id][:file].sub("#{docroot}/", '')[0...-3]
        results << { 
          score: score, 
          file: filename,
          label: filename.gsub("/", " / ")
        }
      end

      index.close()
      results
    end

    private

    def index_dir
      "#{docroot}/_index"
    end  

  end
end
