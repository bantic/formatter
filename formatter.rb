class Formatter
  class << self
    def format(text)
      @separator = separator(text)
      raise "No separator found (should be =>, -> or =)" if @separator.nil?
      
      lines = text.split("\n")
      longest_length = longest_length_before_separator(lines,@separator)
      lines.collect do |line|
        before_sep = match_before_separator(line, @separator)
        sub_with = before_sep + " " * (longest_length - before_sep.length + 1)
        line.sub(/#{before_sep}\s+/, sub_with)
      end.join("\n") + "\n"
    end
    
    def longest_length_before_separator(lines, separator)
      lines.collect do |line|
        match_before_separator(line, separator).length
      end.max
    end
    
    def match_before_separator(line, separator)
      line.match(/(.*)\s+#{separator}/)[1]
    end
    
    def separator(text)
      if match = text.match(/->|=>|=/)
        match[0]
      end
    end
  end
end
