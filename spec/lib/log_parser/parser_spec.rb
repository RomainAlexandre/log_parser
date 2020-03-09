RSpec.describe LogParser::Parser do
  describe '#run' do
    subject { described_class.new(file_path: file_path).run }

    let(:file_path) { "#{File.dirname(__FILE__)}/../../fixtures/webserver.log" }

    let(:expected_logs) do
      {
        "/about/2" => ["444.701.448.104"],
        "/help_page/1" => ["184.123.665.067", "929.398.951.889"],
        "/home" => ["184.123.665.067", "184.123.665.067"]
      }
    end

    it do
      expect(LogParser::WrapperLogger).to receive(:log_visits_per_page).with(logs: expected_logs).once
      expect(LogParser::WrapperLogger).to receive(:log_unique_visit_per_page).with(logs: expected_logs).once
      subject
    end
  end
end