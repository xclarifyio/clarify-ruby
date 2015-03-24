
Given(/^I am using the documentation API key$/) do
  customer.log_in_as_docs
end

Given(/^I am not using an API key$/) do
  customer.clear_api_key
end

Given(/^I am using the environment's API key$/) do
  customer.log_in_via_environment
end
