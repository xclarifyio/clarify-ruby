
describe Clarify::UnrecognizedResponseError do
  let(:response) { 'SomeFutureDataType' }
  let(:error) do
    begin
      fail Clarify::UnrecognizedResponseError, response
    rescue Clarify::UnrecognizedResponseError => e
      e
    end
  end

  it 'allows access to the failing response' do
    expect(error.to_s).to eq 'Unrecognized response class SomeFutureDataType'
  end
end
