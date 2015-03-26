
describe Clarify::RestClient do
  let(:config) { double(:configuration) }
  let(:restclient) { Clarify::RestClient.new(config) }

  describe '#get' do
    it 'creates a get_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(restclient).to receive(:get_request)
        .with('/hi', {}).and_return(request)
      expect(restclient).to receive(:request)
        .with(request).and_return(response)
      expect(restclient.get('/hi')).to eq(response)
    end
  end

  describe '#get_request' do
    subject { restclient.get_request('/bundle/abc123', a: :b) }
    it 'creates a Get request' do
      expect(restclient).to receive(:make_get_url)
        .with('/bundle/abc123', a: :b).and_return('/bundle/abc123?a=b')

      expect(subject).to be_a(Net::HTTP::Get)
      expect(subject.path).to eq('/bundle/abc123?a=b')
    end
  end

  describe '#make_get_url' do
    subject { restclient.make_get_url(url, params) }
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

      expect(restclient).to receive(:post_request)
        .with('/hi', {}).and_return(request)
      expect(restclient).to receive(:request)
        .with(request).and_return(response)
      expect(restclient.post('/hi')).to eq(response)
    end
  end

  describe '#post_request' do
    let(:url) { '/bundle/123' }
    subject { restclient.post_request(url) }
    it { is_expected.to be_a(Net::HTTP::Post) }

    context 'with a body' do
      let(:body) { { 'hi' => 'there' } }
      subject { restclient.post_request(url, body).body }
      it { is_expected.to eq('hi=there') }
    end
  end

  describe '#put' do
    it 'creates a put_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(restclient).to receive(:put_request)
        .with('/hi', {}).and_return(request)
      expect(restclient).to receive(:request)
        .with(request).and_return(response)
      expect(restclient.put('/hi')).to eq(response)
    end
  end

  describe '#put_request' do
    let(:url) { '/bundle/123' }
    subject { restclient.put_request(url) }
    it { is_expected.to be_a(Net::HTTP::Put) }

    context 'with a body' do
      let(:body) { { 'hi' => 'there' } }
      subject { restclient.put_request(url, body).body }
      it { is_expected.to eq('hi=there') }
    end
  end

  describe '#delete' do
    it 'creates a delete_request and passes it to request' do
      request = double(:request)
      response = double(:response)

      expect(restclient).to receive(:delete_request)
        .with('/hi', {}).and_return(request)
      expect(restclient).to receive(:request)
        .with(request).and_return(response)
      expect(restclient.delete('/hi')).to eq(response)
    end
  end

  describe '#delete_request' do
    let(:url) { '/bundle/123' }
    subject { restclient.delete_request(url) }
    it { is_expected.to be_a(Net::HTTP::Delete) }
  end

  describe '#request' do
    let(:connection) { double(:connection) }
    before(:each) do
      expect(restclient).to receive(:connection).and_return(connection)
    end

    it 'pipelines data through blessing, then execution, then result' do
      in_req = double(:request)

      blessed = double(:blessed)
      expect(restclient).to receive(:bless_request)
        .with(in_req).and_return(blessed)

      raw_result = double(:raw_result)
      expect(connection).to receive(:request).with(blessed)
        .and_return(raw_result)

      out_result = double(:result)
      expect(restclient).to receive(:make_result).and_return(out_result)

      expect(restclient.request(in_req)).to eq(out_result)
    end
  end

  describe '#bless_request' do
    subject { restclient.bless_request({}) }
    before(:each) { allow(restclient).to receive(:user_agent).and_return 'UA' }

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
    subject { restclient.user_agent }
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
      expect(restclient).to receive(:response_factory).and_return(factory)

      expect(restclient.make_result(raw_response)).to eq(response)
    end
  end

  describe '#response_factory' do
    it 'returns a ResponseFactory' do
      expect(restclient.response_factory).to be_a(Clarify::ResponseFactory)
    end
  end

  describe '#connection' do
    let(:config) { double(:config, host: 'abc', port: 123, ssl?: true) }
    it 'uses configuration options to generate the connection' do
      expect(restclient.connection.address).to eq('abc')
      expect(restclient.connection.port).to eq(123)
      expect(restclient.connection.use_ssl?).to eq(true)
    end

    context 'without ssl' do
      let(:config) { double(:config, host: 'abc', port: 123, ssl?: false) }
      it 'uses configuration options to generate the connection' do
        expect(restclient.connection.use_ssl?).to eq(false)
      end
    end
  end
end
