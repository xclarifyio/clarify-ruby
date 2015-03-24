
describe Clarify::Responses::Collection do
  it 'iterates over each bundle' do
    track_data = {
      '_links' => {
        'items' => [
          {
            'href' => 'a'
          },
          {
            'href' => 'b'
          }
        ]
      }
    }
    response = Clarify::Responses::Collection.new(track_data, nil)
    expect { |b| response.each(&b) }.to yield_control.twice
    expect(response.to_a).to eq %w(a b)
  end

  describe '#next' do
    subject { Clarify::Responses::Collection.new(track_data, nil).next }

    context 'with a next url' do
      let(:track_data) { { '_links' => { 'next' => { 'href' => 'my-url' } } } }
      it { is_expected.to eq('my-url') }
    end

    context 'with no next url' do
      let(:track_data) { { '_links' => { 'prev' => { 'href' => 'my-url' } } } }
      it { is_expected.to eq(nil) }
    end

    context 'with no _links at all' do
      let(:track_data) { {} }
      it { is_expected.to eq(nil) }
    end
  end

  describe '#more?' do
    subject { Clarify::Responses::Collection.new(track_data, nil).more? }

    context 'with a next url' do
      let(:track_data) { { '_links' => { 'next' => { 'href' => 'my-url' } } } }
      it { is_expected.to eq(true) }
    end

    context 'with no next url' do
      let(:track_data) { { '_links' => { 'prev' => { 'href' => 'my-url' } } } }
      it { is_expected.to eq(false) }
    end

    context 'with no _links at all' do
      let(:track_data) { {} }
      it { is_expected.to eq(false) }
    end
  end
end
