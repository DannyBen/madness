require 'shellwords'

module Madness
  class Search
    include ServerHelper

    using StringRefinements

    def initialize(path = nil)
      @path = path || docroot
    end

    def index
      @index ||= index!
    end

    def search(query)
      query = query.downcase
      words = Shellwords.split query
      word_count = words.count
      result = {}
      return result if words.empty?

      index.each do |file, content|
        file = file.remove("#{@path}/").sub(/.md$/, '')
        url = file_url file
        label = file_label file
        found = 0
        words.each { |word| found += 1 if content.include? word }
        next unless found == word_count

        result[label] = url
      end

      result
    end

  private

    def index!
      results = {}

      Dir["#{@path}/**/#{config.dir_glob}"].each do |file|
        next if skip_index? file

        filename = file_url(file.sub("#{@path}/", '')).downcase
        index_content = File.extname(file) == '.md'
        content = index_content ? File.read(file).downcase : ''
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
        .remove(%r{/(index|README)$})
        .split('/')
        .map(&:to_label)
        .join(' / ')
    end

    def config
      @config ||= Settings.instance
    end

    def file_url(filename)
      filename.remove(%r{/(index|README)$})
    end
  end
end
