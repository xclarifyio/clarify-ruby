
Then(/^I should get the HTTP status code (\d+)$/) do |code|
  expect(@result.http_status_code).to eq code.to_i
end
