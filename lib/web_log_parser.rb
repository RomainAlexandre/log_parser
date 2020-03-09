require 'log_parser/validator'
require 'log_parser/parser'

class WebLogParser
  class << self
    def run(arguments)
      file_path, *other_arguments = *arguments
      if LogParser::Validator.valid_argument?(file_path: file_path, other_arguments: other_arguments)
        LogParser::Parser.new(file_path: file_path).run
      end
    end
  end
end
