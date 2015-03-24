
describe Clarify::Responses::Bundle do
  describe '#name' do
    let(:body) { { 'name' => 'foobar' } }
    subject { Clarify::Responses::Bundle.new(body, nil).name }
    it { is_expected.to eq('foobar') }
  end
end
