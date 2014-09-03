def format_data_characteristics(table)

  puts table.raw

  data_characteristics = {}

  table.raw.each do |value|
    if (value[0] != 'CHARACTERISTICS') then
      data_characteristics[value[0]] = true
    end
  end

  return data_characteristics

end
