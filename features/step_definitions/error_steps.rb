
Then(/^the response should be rejected with a 401 Unauthorized status code$/) do
  expect(exceptions.caught.class.to_s).to eq('Clarify::UnauthenticatedError')
end
