
describe Clarify::Response do
  describe '#http_status_code' do
    it 'returns the int version of the response status code' do
      response = Clarify::Response.new(nil, double(:response, code: '201'))

      expect(response.http_status_code).to eq(201)
    end
  end

  describe '#relation!' do
    context 'with a present relation' do
      let(:body) { { '_links' => { 'self' => { 'href' => 'my-url' } } } }
      it 'returns the value from the relation' do
        expect(Clarify::Response.new(body, nil).relation!('self'))
          .to eq('my-url')
      end
    end

    context 'without a relation present' do
      let(:body) { {} }
      it 'raises an error' do
        expect do
          Clarify::Response.new(body, nil).relation!('self')
        end.to raise_error ArgumentError
      end
    end
  end

  describe '#relation' do
    it 'returns a href for a single value relation' do
      body = {
        '_links' => {
          'test_value' => {
            'href' => 'http://example.com'
          }
        }
      }
      response = Clarify::Response.new(body, nil)

      expect(response.relation('test_value')).to eq('http://example.com')
    end

    context 'with a single element' do
      subject do
        Clarify::Responses::Collection.new(track_data, nil).relation('next')
      end

      context 'with a next url' do
        let(:track_data) do
          { '_links' => { 'next' => { 'href' => 'my-url' } } }
        end
        it { is_expected.to eq('my-url') }
      end

      context 'with no next url' do
        let(:track_data) do
          { '_links' => { 'prev' => { 'href' => 'my-url' } } }
        end
        it { is_expected.to eq(nil) }
      end

      context 'with no _links at all' do
        let(:track_data) { {} }
        it { is_expected.to eq(nil) }
      end
    end
  end
end
