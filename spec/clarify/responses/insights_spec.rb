
describe Clarify::Responses::Insights do
  let(:body) do
    {
      '_links' => {
        'self' => { 'href' => 'foo' },
        'parent' => { 'href' => 'bar' },
        'insight:foo' => { 'href' => 'baz' }
      }
    }
  end

  describe '#each' do
    it 'iterates over each insight' do
      insights = Clarify::Responses::Insights.new(body, nil)

      expect { |b| insights.each(&b) }.to yield_control.once
      expect(insights.to_h).to eq('insight:foo' => 'baz')
    end
  end

  describe '#items' do
    subject { Clarify::Responses::Insights.new(body, nil).items }

    it { is_expected.to eq('insight:foo' => { 'href' => 'baz' }) }
  end
end
