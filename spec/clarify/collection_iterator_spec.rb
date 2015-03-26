
describe Clarify::CollectionIterator do
  describe '#collections' do
    let(:coll1) { double(:collection1, next: 2, more?: true) }
    let(:coll2) { double(:collection2, next: 3, more?: true) }
    let(:coll3) { double(:collection2, more?: false) }

    let(:restclient) do
      restclient = double(:restclient)
      allow(restclient).to receive(:get).with(any_args)
        .and_return(coll1, coll2, coll3)

      restclient
    end
    let(:iterator) do
      Clarify::CollectionIterator.new(restclient, restclient.get(1))
    end

    it 'iterates over all three collections' do
      expect(iterator.collections.to_a).to eq([coll1, coll2, coll3])
    end
  end

  describe '#each' do
    let(:coll1) do
      c = double(:collection1, next: 2, more?: true)
      allow(c).to receive(:each).once.and_yield(1).and_yield(2).and_yield(3)
      c
    end
    let(:coll2) do
      c = double(:collection2, next: 3, more?: true)
      allow(c).to receive(:each).once.and_yield(4).and_yield(5).and_yield(6)
      c
    end
    let(:coll3) do
      c = double(:collection3, more?: false)
      allow(c).to receive(:each).once.and_yield(7).and_yield(8).and_yield(9)
      c
    end

    let(:restclient) do
      restclient = double(:restclient)
      allow(restclient).to receive(:get).with(any_args)
        .and_return(coll1, coll2, coll3)

      restclient
    end
    let(:iterator) do
      Clarify::CollectionIterator.new(restclient, restclient.get(1))
    end

    it 'iterates over all the elements inside each collection' do
      expect(iterator.to_a).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  context 'with search results which yield two variables' do
    describe '#each' do
      let(:coll1) do
        c = double(:collection1, next: 2, more?: true)
        allow(c).to receive(:each).once.and_yield(1, 2).and_yield(3, 4)
        c
      end
      let(:coll2) do
        c = double(:collection2, more?: false)
        allow(c).to receive(:each).once.and_yield(5, 6).and_yield(7, 8)
        c
      end

      let(:restclient) do
        restclient = double(:restclient)
        allow(restclient).to receive(:get).with(any_args)
          .and_return(coll1, coll2)

        restclient
      end
      let(:iterator) do
        Clarify::CollectionIterator.new(restclient, restclient.get(1))
      end

      it 'iterates over all the elements inside each collection' do
        expect(iterator.to_a).to eq([[1, 2], [3, 4], [5, 6], [7, 8]])
      end
    end
  end
end
