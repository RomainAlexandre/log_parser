RSpec.describe WebLogParser do
  describe '.run' do
    subject { described_class.run(arguments) }

    context 'when arguments is an empty array' do
      let(:arguments) { [] }
      it do
        expect(LogParser::Validator).to receive(:valid_argument?).with(file_path: nil, other_arguments: []) { false }
        expect(LogParser::Parser).to_not receive(:new)
        subject
      end
    end

    context 'when arguments only have one value' do
      let(:arguments) { ['file_path.log'] }
      it do
        expect(LogParser::Validator).to receive(:valid_argument?).with(file_path: arguments.first, other_arguments: []) { true }
        expect(LogParser::Parser).to receive(:new).with(file_path: arguments.first).once { double('parser', run: true) }
        subject
      end
    end

    context 'when arguments have multiple values' do
      let(:arguments) { ['file_path.log', 'another_param', 'one more param'] }
      it do
        expect(LogParser::Validator).to receive(:valid_argument?).with(file_path: arguments.first, other_arguments: arguments.last(2)) { true }
        expect(LogParser::Parser).to receive(:new).with(file_path: arguments.first).once { double('parser', run: true) }
        subject
      end
    end
  end
end