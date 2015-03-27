
describe Clarify::Client do
  let(:opts) { {} }
  let(:config) { { api_key: 'abc123' } }
  let(:client) { Clarify::Client.new(config, opts) }

  context 'with a fake restclient' do
    let(:url) { double(:url) }
    let(:params) { double(:params) }
    let(:restclient) { double(:restclient) }
    before(:each) do
      allow(client).to receive(:restclient).and_return(restclient)
    end
    describe '#get' do
      it 'calls get on the restclient' do
        expect(restclient).to receive(:get).with(url, params)
        client.get(url, params)
      end
    end

    describe '#put' do
      it 'calls put on the restclient' do
        expect(restclient).to receive(:put).with(url, params)
        client.put(url, params)
      end
    end

    describe '#post' do
      it 'calls post on the restclient' do
        expect(restclient).to receive(:post).with(url, params)
        client.post(url, params)
      end
    end

    describe '#delete' do
      it 'calls delete on the restclient' do
        expect(restclient).to receive(:delete).with(url, params)
        client.delete(url, params)
      end
    end
  end

  describe '#pager' do
    let(:collection) { double(:collection) }
    let(:restclient) { double(:restclient) }
    let(:iterator_klass) { double(:iterator_klass) }
    let(:opts) { { iterator: iterator_klass } }
    it 'creates an iterator with the restclient' do
      expect(client).to receive(:restclient).and_return(restclient)
      expect(iterator_klass).to receive(:new).with(restclient, collection)
      client.pager(collection)
    end
  end

  describe '#bundles' do
    let(:repo) { double(:repo) }
    it 'calls the bundle_repository method' do
      expect(client).to receive(:bundle_repository).and_return(repo)
      expect(client.bundles).to eq(repo)
    end
  end

  describe '#bundle_repository' do
    let(:restclient) { double(:restclient) }
    let(:bundle_klass) { double(:bundle_klass) }
    let(:opts) { { bundle_repository: bundle_klass } }
    it 'creates a bundle repository with the restclient' do
      expect(client).to receive(:restclient).and_return(restclient)
      expect(bundle_klass).to receive(:new).with(restclient)
      client.bundle_repository
    end
  end

  describe '#restclient' do
    let(:configuration) { double(:configuration) }
    let(:restclient_klass) { double(:restclient_klass) }
    let(:opts) { { rest_client: restclient_klass } }
    it 'creates a new restclient with the configuration' do
      expect(client).to receive(:configuration).and_return(configuration)
      expect(restclient_klass).to receive(:new).with(configuration)
      client.restclient
    end
  end

  describe '#configuration' do
    let(:config_klass) { double(:config_klass) }
    let(:opts) { { configuration: config_klass } }
    it 'should create a new Configuration from the opts' do
      expect(config_klass).to receive(:new).with(config)
      client.configuration
    end
  end
end
