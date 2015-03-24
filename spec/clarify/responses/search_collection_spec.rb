
describe Clarify::Responses::SearchCollection do
  let(:response) { double(:response) }
  let(:body) do
    {
      'item_results' => [
        { 'name' => '1_result' },
        { 'name' => '2_result' }
      ],
      '_links' => {
        'items' => [
          { 'href' => '1_link' },
          { 'href' => '2_link' }
        ]
      }
    }
  end
  let(:search) { Clarify::Responses::SearchCollection.new(body, response) }

  describe '#items' do
    it 'returns an array of links and results' do
      expect(search.items).to eq([
        [{ 'name' => '1_result' }, { 'href' => '1_link' }],
        [{ 'name' => '2_result' }, { 'href' => '2_link' }]
      ])
    end
  end

  describe '#each' do
    it 'yields per result' do
      expect { |b| search.each(&b) }.to yield_control.twice
    end
    it 'yields object, ul' do
      expect(search.to_a).to eq([
        [{ 'name' => '1_result' }, '1_link'],
        [{ 'name' => '2_result' }, '2_link']
      ])
    end
  end
end
