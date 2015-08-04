
When(/^I request a list of bundles without authentication$/) do
  begin
    @result = customer.bundle_repository.fetch
  rescue Clarify::StandardError => err
    exceptions.caught = err
  end
end

When(/^I request a list of bundles$/) do
  @result = customer.bundle_repository.fetch
end

When(/^I search my bundles for the text "(.*?)"$/) do |query_string|
  @result = customer.bundle_repository.search(query_string)
end

Then(/^my results should include a track with the URL "(.*?)"$/) do |url|
  if @result.is_a? Clarify::Responses::SearchCollection
    urls = @result.map { |_, bundle_url| bundle_url }
  else
    urls = @result.to_a
  end

  bundles = urls.map { |bundle_url| customer.restclient.get(bundle_url) }

  tracks = bundles.map do |bundle|
    customer.restclient.get(bundle.relation('clarify:tracks'))
  end
  media_urls = tracks.map do |tracks_resource|
    tracks_resource.map { |track| track['media_url'] }
  end.flatten

  expect(media_urls).to include(curies.resolve(url))
end

Then(/^my bundle has exactly "(\d+)" tracks?$/) do |count|
  tracks = customer.restclient.get(@my_bundle.relation('clarify:tracks'))

  media_urls = tracks.map { |track| track['media_url'] }

  expect(media_urls.length).to eq(count.to_i)
end

Then(/^my bundle should include a track with the URL "(.*?)"$/) do |url|
  tracks = customer.restclient.get(@my_bundle.relation('clarify:tracks'))

  media_urls = tracks.map { |track| track['media_url'] }

  expect(media_urls).to include(curies.resolve(url))
end

# rubocop:disable Metrics/LineLength
When(/^I create a bundle named "(.*?)" with the media url "(.*?)"$/) do |name, url|
  # rubocop:enable Metrics/LineLength
  bundle = {
    name: names.translate(name),
    media_url: curies.resolve(url)
  }
  customer.bundle_repository.create!(bundle)
end

Then(/^my results should incude a bundle named "(.*?)"$/) do |name|
  all_results = Clarify::CollectionIterator.new(customer.restclient, @result)
  bundles = all_results.map do |item|
    customer.restclient.get(item)
  end
  bundle_names = bundles.map(&:name)

  expect(bundle_names).to include(names.translate(name))
end

Given(/^I have a bundle named "(.*?)"$/) do |name|
  bundle = {
    name: names.translate(name)
  }
  @my_bundle = customer.bundle_repository.create!(bundle)
end

When(/^I add a track with the URL "(.*?)" to the bundle$/) do |url|
  create_url = @my_bundle.relation!('clarify:tracks')

  @result = customer.client.post(create_url, media_url: curies.resolve(url))
end

When(/^I delete my bundle$/) do
  customer.bundle_repository.delete!(@my_bundle)
end

Then(/^the server should not list my bundle$/) do
  result = customer.bundle_repository.fetch
  all_results = Clarify::CollectionIterator.new(customer.restclient, result)
  bundle_urls = all_results.map do |item|
    item['href']
  end

  expect(bundle_urls).to_not include(@my_bundle.relation('self'))
end
