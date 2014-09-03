Given(/^I have a registered propertyB$/) do |table|

  data_characteristics = format_data_characteristics(table)

  puts data_characteristics

  step "I have registered Freehold property data"

  $regData['extent'] = genenerate_title_extent2(data_characteristics)
  $regData['easements'] = Array.new()
  $regData['easements'] = []
  $regData['easements'][0] = {}
  $regData['easements'][0]['easement_geometry'] = genenerate_title_easement2(data_characteristics)
  $regData['easements'][0]['easement_description'] = 'Easement Description'

  puts $regData
  step "I submit the registered property data"
end
