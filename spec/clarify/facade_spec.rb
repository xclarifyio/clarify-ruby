
describe Clarify::Facade do
  let(:opts) { {} }
  let(:config) { { api_key: 'abc123' } }
  let(:facade) { Clarify::Facade.new(config, opts) }

  context 'with a fake client' do
    let(:url) { double(:url) }
    let(:params) { double(:params) }
    let(:client) { double(:client) }
    before(:each) { allow(facade).to receive(:client).and_return(client) }
    describe '#get' do
      it 'calls get on the client' do
        expect(client).to receive(:get).with(url, params)
        facade.get(url, params)
      end
    end

    describe '#put' do
      it 'calls put on the client' do
        expect(client).to receive(:put).with(url, params)
        facade.put(url, params)
      end
    end

    describe '#post' do
      it 'calls post on the client' do
        expect(client).to receive(:post).with(url, params)
        facade.post(url, params)
      end
    end

    describe '#delete' do
      it 'calls delete on the client' do
        expect(client).to receive(:delete).with(url, params)
        facade.delete(url, params)
      end
    end
  end

  describe '#pager' do
    let(:collection) { double(:collection) }
    let(:client) { double(:client) }
    let(:iterator_klass) { double(:iterator_klass) }
    let(:opts) { { iterator: iterator_klass } }
    it 'creates an iterator with the client' do
      expect(facade).to receive(:client).and_return(client)
      expect(iterator_klass).to receive(:new).with(client, collection)
      facade.pager(collection)
    end
  end

  describe '#bundles' do
    let(:repo) { double(:repo) }
    it 'calls the bundle_repository method' do
      expect(facade).to receive(:bundle_repository).and_return(repo)
      expect(facade.bundles).to eq(repo)
    end
  end

  describe '#bundle_repository' do
    let(:client) { double(:client) }
    let(:bundle_klass) { double(:bundle_klass) }
    let(:opts) { { bundle_repository: bundle_klass } }
    it 'creates a bundle repository with the client' do
      expect(facade).to receive(:client).and_return(client)
      expect(bundle_klass).to receive(:new).with(client)
      facade.bundle_repository
    end
  end

  describe '#client' do
    let(:configuration) { double(:configuration) }
    let(:client_klass) { double(:client_klass) }
    let(:opts) { { client: client_klass } }
    it 'creates a new client with the configuration' do
      expect(facade).to receive(:configuration).and_return(configuration)
      expect(client_klass).to receive(:new).with(configuration)
      facade.client
    end
  end

  describe '#configuration' do
    let(:config_klass) { double(:config_klass) }
    let(:opts) { { configuration: config_klass } }
    it 'should create a new Configuration from the opts' do
      expect(config_klass).to receive(:new).with(config)
      facade.configuration
    end
  end
end
