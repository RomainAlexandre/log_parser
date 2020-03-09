require 'log_parser/wrapper_logger'

module LogParser
  class Validator
    class << self
      def valid_argument?(file_path:, other_arguments:)
        check_warnings(other_arguments)
        valid_argument_presence?(file_path) && valid_first_argument_file_path?(file_path)
      end

    private

      def valid_argument_presence?(file_path)
        if file_path.nil?
          LogParser::WrapperLogger.logger.error("You must provide a file path as first parameter")
          false
        else
          true
        end
      end

      def valid_first_argument_file_path?(file_path)
        if !File.exist?(file_path)
          LogParser::WrapperLogger.logger.error("First parameter must be a path to a log file")
          false
        else
          true
        end
      end

      def check_warnings(other_arguments)
        if other_arguments && other_arguments.size > 0
          LogParser::WrapperLogger.logger.warn("Other arguments will be ignore. Only first argument will be used")
        end
      end
    end
  end
end
