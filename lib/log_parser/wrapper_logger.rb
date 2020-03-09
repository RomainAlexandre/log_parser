require 'logger'

module LogParser
  class WrapperLogger
    class << self
      def logger
        @@logger ||= Logger.new(STDOUT)
      end

      def log_visits_per_page(logs:)
        logger.info("Number of visits per page:")
        logs.sort_by { |_, ips| -ips.count }.each do |path, ips|
          logger.info("#{path} #{ips.count} visits")
        end
      end

      def log_unique_visit_per_page(logs:)
        logger.info("Number of unique views per page:")
        logs.sort_by { |_, ips| -ips.uniq.count }.each do |path, ips|
          logger.info("#{path} #{ips.uniq.count} unique views")
        end
      end
    end
  end
end
