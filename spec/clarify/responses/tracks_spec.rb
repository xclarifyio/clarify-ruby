
describe Clarify::Responses::Tracks do
  it 'iterates over each track' do
    track_data = {
      'tracks' => [
        {
          'media_url' => 'a'
        },
        {
          'media_url' => 'b'
        }
      ]
    }
    response = Clarify::Responses::Tracks.new(track_data, nil)
    expect { |b| response.each(&b) }.to yield_control.twice
    expect(response.map { |t| t['media_url'] }).to eq %w(a b)
  end
end
