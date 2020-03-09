RSpec.describe LogParser::WrapperLogger do

  let(:logs) do
    {
      "/about/2" => ["444.701.448.104"],
      "/help_page/1" => ["184.123.665.067", "929.398.951.889"],
      "/home" => ["184.123.665.067", "184.123.665.067"]
    }
  end

  describe '.log_visits_per_page' do
    subject { described_class.log_visits_per_page(logs: logs) }

    it do
      logger = double('logger')
      expect(LogParser::WrapperLogger).to receive(:logger).exactly(4).times { logger }
      expect(logger).to receive(:info).with("Number of visits per page:").once
      expect(logger).to receive(:info).with("/home 2 visits").once
      expect(logger).to receive(:info).with("/help_page/1 2 visits").once
      expect(logger).to receive(:info).with("/about/2 1 visits").once
      subject
    end
  end

  describe '.log_unique_visit_per_page' do
    subject { described_class.log_unique_visit_per_page(logs: logs) }

    it do
      logger = double('logger')
      expect(LogParser::WrapperLogger).to receive(:logger).exactly(4).times { logger }
      expect(logger).to receive(:info).with("Number of unique views per page:").once
      expect(logger).to receive(:info).with("/help_page/1 2 unique views").once
      expect(logger).to receive(:info).with("/home 1 unique views").once
      expect(logger).to receive(:info).with("/about/2 1 unique views").once
      subject
    end
  end
end