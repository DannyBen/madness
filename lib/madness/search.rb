module Madness
  class Search
    include ServerHelper
    using StringRefinements

    def initialize(path=nil)
      @path = path || docroot
    end

    def index
      @index ||= index!
    end

    def search(query)
      query = query.downcase
      result = {}

      index.each do |file, content|
        file = file.remove("#{@path}/")[0...-3]
        url = file_url file
        label = file_label file
        next unless content.include? query
        result[label] = url
      end

      result
    end

  private

    def index!
      results = {}
      Dir["#{@path}/**/*.md"].sort.each do |file|
        next if skip_index? file
        filename = file_url(file.sub("#{@path}/", '')[0...-3]).downcase
        content = File.read(file).downcase
        results[file] = "#{filename} #{content}"
      end
      results
    end

    # We are going to avoid indexing of README.md when there is also an
    # index.md in the same directory, to keep behavior consistent with the 
    # display logic
    def skip_index?(file)
      if file.end_with? 'README.md'
        dir = File.dirname file
        File.exist? "#{dir}/index.md"
      else
        false
      end
    end

    def file_label(filename)
      filename
        .remove(/\/(index|README)$/)
        .split('/')
        .map { |i| i.to_label }
        .join(' / ')
    end

    def config
      @config ||= Settings.instance
    end

    def file_url(filename)
      filename.remove(/\/(index|README)$/)
    end
  end
end
