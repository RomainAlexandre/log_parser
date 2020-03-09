require 'log_parser/wrapper_logger'

module LogParser
  class Parser
    attr_reader :file

    def initialize(file_path:)
      @file = File.open(file_path)
    end

    def run
      logs = file.readlines.each_with_object(Hash.new([])).with_index(1) do |(line, grouped_logs), line_number|
        uri, ip_string = line.split(" ")
        grouped_logs[uri] += [ip_string]
      end
      WrapperLogger.log_visits_per_page(logs: logs)
      WrapperLogger.log_unique_visit_per_page(logs: logs)
    end
  end
end
