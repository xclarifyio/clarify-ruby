
describe Clarify::Configuration do
  let(:api_key) { double(:api_key) }
  let(:server) { 'https://example.com/' }
  let(:configuration) do
    Clarify::Configuration.new(api_key: api_key, server: server)
  end

  describe '#api_key?' do
    subject { configuration.api_key? }
    context 'when the api key is nil' do
      let(:api_key) { nil }
      it { is_expected.to eq(false) }
    end

    context 'when the api key is empty' do
      let(:api_key) { '' }
      it { is_expected.to eq(false) }
    end

    context 'when the api key is correctly entered' do
      let(:api_key) { 'abc123' }
      it { is_expected.to eq(true) }
    end
  end

  describe '#ssl?' do
    subject { configuration.ssl? }
    context 'the URL has https specified' do
      let(:server) { 'https://example.com' }
      it { is_expected.to eq(true) }
    end

    context 'the URL has http specified' do
      let(:server) { 'http://example.com' }
      it { is_expected.to eq(false) }
    end

    context 'the URL has nothing specified' do
      let(:server) { 'example.com' }
      it { is_expected.to eq(false) }
    end
  end

  describe '#host' do
    subject { configuration.host }
    it { is_expected.to eq('example.com') }
  end

  describe '#port' do
    subject { configuration.port }

    context 'with https' do
      context 'with a custom port' do
        let(:server) { 'https://example.com:444' }
        it { is_expected.to eq(444) }
      end

      context 'without a custom port' do
        let(:server) { 'https://example.com' }
        it { is_expected.to eq(443) }
      end
    end

    context 'with http' do
      context 'with a custom port' do
        let(:server) { 'http://example.com:8080' }
        it { is_expected.to eq(8080) }
      end

      context 'without a custom port' do
        let(:server) { 'http://example.com' }
        it { is_expected.to eq(80) }
      end
    end
  end
end
