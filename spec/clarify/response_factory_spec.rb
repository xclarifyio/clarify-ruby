
describe Clarify::ResponseFactory do
  let(:factory) { Clarify::ResponseFactory.new }

  describe '#make_result' do
    context 'the server sent a Collection type' do
      it 'returns a Clarify::Responses::Collection' do
        response = double(:response,
                          body: '{"_class": "Collection"}',
                          code: '200'
                         )

        result = factory.make_result(response)
        expect(result).to be_a(Clarify::Responses::Collection)
      end
    end

    context 'the server sent an unrecognized type' do
      it 'raises an UnrecognizedResponseError' do
        response = double(:response, body: '{"_class": "FooBarClass"}')
        allow(factory).to receive(:raise_on_code!)

        expect { factory.make_result(response) }.to raise_error(
          Clarify::UnrecognizedResponseError,
          'Unrecognized response class FooBarClass')
      end
    end

    context 'the response has no body' do
      let(:response) do
        double(:response, code: 204, body: nil)
      end
      subject { factory.make_result(response) }
      it { is_expected.to be_a(Clarify::Responses::NoBody) }
    end
  end

  describe '#raise_on_code!' do
    it 'does nothing on a 200' do
      response = double(:response, code: '200')
      expect(factory.raise_on_code!(response)).to eq(nil)
    end

    it 'raises UnauthenticatedError on 401' do
      response = double(:response, code: '401')
      expect { factory.raise_on_code!(response) }.to raise_error(
        Clarify::UnauthenticatedError
      )
    end
  end
end
