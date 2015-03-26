
describe Clarify::BundleRepository do
  let(:restclient) { double(:restclient) }
  let(:repo) { Clarify::BundleRepository.new(restclient) }

  describe '#fetch' do
    it 'performs a get on the restclient' do
      expect(restclient).to receive(:get).with('/v1/bundles')
      repo.fetch
    end
  end

  describe '#search' do
    it 'performs a get on the restclient' do
      expect(restclient).to receive(:get).with('/v1/search', query: 'abc')
      repo.search 'abc'
    end
  end

  describe '#create!' do
    it 'performs a post on the restclient' do
      body = { hey: :there }
      expect(restclient).to receive(:post).with('/v1/bundles', body)
      repo.create! body
    end
  end

  describe '#delete!' do
    it 'performs a delete on the restclient' do
      bundle = double(:bundle)
      expect(bundle).to receive(:relation!)
        .with('self').and_return('/v1/bundle/thisone')
      expect(restclient).to receive(:delete).with('/v1/bundle/thisone')
      repo.delete! bundle
    end
  end
end
