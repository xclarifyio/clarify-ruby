Given(/^I know the following urls referenced as:$/) do |table|
  table.map_headers! { |header| header.downcase.to_sym }
  table.hashes.each do |row|
    curies[row[:name]] = row[:url]
  end
end
