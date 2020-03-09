RSpec.describe LogParser::Validator do
  describe '.valid_argument?' do
    subject { described_class.valid_argument?(file_path: file_path, other_arguments: other_arguments) }

    context "when file_path is nil" do
      let(:file_path) { nil }
      let(:other_arguments) { [] }

      it do
        logger = double('logger')
        expect(LogParser::WrapperLogger).to receive(:logger).once { logger }
        expect(logger).to receive(:error).with("You must provide a file path as first parameter").once
        expect(subject).to eq(false)
      end
    end

    context "when file_path is present" do
      context "and other_arguments is empty" do
        let(:other_arguments) { [] }

        context "and file_path is a valid file" do
          let(:file_path) { "#{File.dirname(__FILE__)}/../../fixtures/webserver.log" }

          it do
            expect(LogParser::WrapperLogger).to_not receive(:logger)
            expect(subject).to eq(true)
          end
        end

        context "and file_path is an invalid file" do
          let(:file_path) { "not_a_file" }

          it do
            logger = double('logger')
            expect(LogParser::WrapperLogger).to receive(:logger).once { logger }
            expect(logger).to receive(:error).with("First parameter must be a path to a log file").once
            expect(subject).to eq(false)
          end
        end
      end
    end

    context "when other_arguments is present" do
      let(:other_arguments) { ['another_argument'] }

      context "and file_path is a valid file" do
        let(:file_path) { "#{File.dirname(__FILE__)}/../../fixtures/webserver.log" }

        it do
          logger = double('logger')
          expect(LogParser::WrapperLogger).to receive(:logger).once { logger }
          expect(logger).to receive(:warn).with("Other arguments will be ignore. Only first argument will be used").once
          expect(subject).to eq(true)
        end
      end

      context "and file_path is an invalid file" do
        let(:file_path) { "not_a_file" }

        it do
          logger = double('logger')
          expect(LogParser::WrapperLogger).to receive(:logger).twice { logger }
          expect(logger).to receive(:warn).with("Other arguments will be ignore. Only first argument will be used").once
          expect(logger).to receive(:error).with("First parameter must be a path to a log file").once
          expect(subject).to eq(false)
        end
      end

    end
  end
end