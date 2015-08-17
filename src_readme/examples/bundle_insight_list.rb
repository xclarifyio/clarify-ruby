require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/d6dcddf1066b4dd4bed78334e553e233'
bundle = clarify.get(bundle_url)

bundle_insights_url = bundle.relation('clarify:insights')

puts "Insights for Bundle Name: #{bundle.name} (#{bundle_insights_url})"
insights = clarify.get(bundle_insights_url)
pp insights
puts '-----------'
insights.each do |insight, insight_url|
  puts "Insight #{insight} (#{insight_url})"
  insight = clarify.get(insight_url)
  pp insight
  puts ''
  puts ''
  puts ''
end
