
describe Clarify::BundleRepository do
  let(:client) { double(:client) }
  let(:repo) { Clarify::BundleRepository.new(client) }

  describe '#fetch' do
    it 'performs a get on the client' do
      expect(client).to receive(:get).with('/v1/bundles')
      repo.fetch
    end
  end

  describe '#search' do
    it 'performs a get on the client' do
      expect(client).to receive(:get).with('/v1/search', query: 'abc')
      repo.search 'abc'
    end
  end

  describe '#create!' do
    it 'performs a post on the client' do
      body = { hey: :there }
      expect(client).to receive(:post).with('/v1/bundles', body)
      repo.create! body
    end
  end

  describe '#delete!' do
    it 'performs a delete on the client' do
      bundle = double(:bundle)
      expect(bundle).to receive(:relation!)
        .with('self').and_return('/v1/bundle/thisone')
      expect(client).to receive(:delete).with('/v1/bundle/thisone')
      repo.delete! bundle
    end
  end
end
