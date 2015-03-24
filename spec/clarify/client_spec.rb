
describe Clarify::Client do
  let(:config) { double(:configuration) }
  let(:client) { Clarify::Client.new(config) }

  describe '#get' do
    it 'creates a get_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(client).to receive(:get_request)
        .with('/hi', {}).and_return(request)
      expect(client).to receive(:request)
        .with(request).and_return(response)
      expect(client.get('/hi')).to eq(response)
    end
  end

  describe '#get_request' do
    subject { client.get_request('/bundle/abc123', a: :b) }
    it 'creates a Get request' do
      expect(client).to receive(:make_get_url)
        .with('/bundle/abc123', a: :b).and_return('/bundle/abc123?a=b')

      expect(subject).to be_a(Net::HTTP::Get)
      expect(subject.path).to eq('/bundle/abc123?a=b')
    end
  end

  describe '#make_get_url' do
    subject { client.make_get_url(url, params) }
    context 'with no URL parameters on the input url' do
      let(:url) { '/bundle/abc123' }

      context 'with no query parameters' do
        let(:params) { {} }

        it { is_expected.to eq('/bundle/abc123') }
      end

      context 'with a few query parameters' do
        let(:params) { { a: :b } }

        it { is_expected.to eq('/bundle/abc123?a=b') }
      end
    end

    context 'with URL parameters on the input url' do
      let(:url) { '/bundle/abc123?a=b' }

      context 'with no query parameters' do
        let(:params) { {} }

        it { is_expected.to eq('/bundle/abc123?a=b') }
      end

      context 'with a few query parameters' do
        let(:params) { { c: :d } }

        it { is_expected.to eq('/bundle/abc123?a=b&c=d') }
      end
    end
  end

  describe '#post' do
    it 'creates a post_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(client).to receive(:post_request)
        .with('/hi', {}).and_return(request)
      expect(client).to receive(:request)
        .with(request).and_return(response)
      expect(client.post('/hi')).to eq(response)
    end
  end

  describe '#post_request' do
    let(:url) { '/bundle/123' }
    subject { client.post_request(url) }
    it { is_expected.to be_a(Net::HTTP::Post) }

    context 'with a body' do
      let(:body) { { 'hi': 'there' } }
      subject { client.post_request(url, body).body }
      it { is_expected.to eq('hi=there') }
    end
  end

  describe '#put' do
    it 'creates a put_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(client).to receive(:put_request)
        .with('/hi', {}).and_return(request)
      expect(client).to receive(:request)
        .with(request).and_return(response)
      expect(client.put('/hi')).to eq(response)
    end
  end

  describe '#put_request' do
    let(:url) { '/bundle/123' }
    subject { client.put_request(url) }
    it { is_expected.to be_a(Net::HTTP::Put) }

    context 'with a body' do
      let(:body) { { 'hi': 'there' } }
      subject { client.put_request(url, body).body }
      it { is_expected.to eq('hi=there') }
    end
  end

  describe '#delete' do
    it 'creates a delete_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(client).to receive(:delete_request)
        .with('/hi', {}).and_return(request)
      expect(client).to receive(:request)
        .with(request).and_return(response)
      expect(client.delete('/hi')).to eq(response)
    end
  end

  describe '#delete_request' do
    let(:url) { '/bundle/123' }
    subject { client.delete_request(url) }
    it { is_expected.to be_a(Net::HTTP::Delete) }
  end

  describe '#request' do
    let(:connection) { double(:connection) }
    before(:each) do
      expect(client).to receive(:connection).and_return(connection)
    end

    it 'pipelines data through blessing, then execution, then result' do
      in_req = double(:request)

      blessed = double(:blessed)
      expect(client).to receive(:bless_request).with(in_req).and_return(blessed)

      raw_result = double(:raw_result)
      expect(connection).to receive(:request).with(blessed)
        .and_return(raw_result)

      out_result = double(:result)
      expect(client).to receive(:make_result).and_return(out_result)

      expect(client.request(in_req)).to eq(out_result)
    end
  end

  describe '#bless_request' do
    subject { client.bless_request({}) }
    before(:each) { allow(client).to receive(:user_agent).and_return 'UA' }

    context 'with no API key' do
      let(:config) { double(:config, api_key?: false) }
      it { is_expected.to eq('User-Agent' => 'UA') }
    end

    context 'with an API key' do
      let(:config) { double(:config, api_key?: true, api_key: 'abc123') }
      it do
        headers = {
          'User-Agent' => 'UA',
          'Authorization' => 'Bearer abc123'
        }
        is_expected.to eq(headers)
      end
    end
  end

  describe '#user_agent' do
    subject { client.user_agent }
    it do
      ruby_id = "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

      expect(subject).to eq("clarify-ruby/#{Clarify::VERSION}/#{ruby_id}")
    end
  end

  describe '#make_result' do
    it 'passes the response to the factory' do
      raw_response = double(:raw_response)
      response = double(:response)
      factory = double(:factory)
      expect(factory).to receive(:make_result).with(raw_response)
        .and_return(response)
      expect(client).to receive(:response_factory).and_return(factory)

      expect(client.make_result(raw_response)).to eq(response)
    end
  end

  describe '#response_factory' do
    it 'returns a ResponseFactory' do
      expect(client.response_factory).to be_a(Clarify::ResponseFactory)
    end
  end

  describe '#connection' do
    let(:config) { double(:config, host: 'abc', port: 123, ssl?: true) }
    it 'uses configuration options to generate the connection' do
      expect(client.connection.address).to eq('abc')
      expect(client.connection.port).to eq(123)
      expect(client.connection.use_ssl?).to eq(true)
    end

    context 'without ssl' do
      let(:config) { double(:config, host: 'abc', port: 123, ssl?: false) }
      it 'uses configuration options to generate the connection' do
        expect(client.connection.use_ssl?).to eq(false)
      end
    end
  end
end
