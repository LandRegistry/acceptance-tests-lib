Given(/^historical versions of the register exist$/) do
  $historical_data = create_historical_data()
  for i in 0..2 do
    post_to_historical($historical_data, $regData['title_number'])
  end
end

Then(/^the correct historical versions of the register are displayed$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/" + $regData['title_number'])
  click_link('View pending and historical changes to this title')
  title_version_history = get_all_historical_titles($regData['title_number'])
  for i in 0..2 do
    puts title_version_history[i]
    puts title_version_history[i]["contents"]
  end
end

Then(/^historical versions of the register are not editable$/) do
  pending # express the regexp above with the code you wish you had
end
