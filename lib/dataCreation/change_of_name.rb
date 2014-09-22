def create_marriage_data(country, full_name)
  marriage_data = {}
  marriage_data['proprietor_full_name'] = full_name
  marriage_data['proprietor_new_full_name'] = fullName()
  marriage_data['partner_name'] = fullName()
  marriage_data['marriage_date'] = dateInThePast().strftime("%d-%m-%Y")
  marriage_data['marriage_place'] = townName()
  marriage_data['marriage_country'] = country
  marriage_data['marriage_certificate_number'] = certificateNumber()

  if ($PERFROMANCETEST.nil?) then
    $function_call_name << 'create_marriage_data'
    $function_call_data << marriage_data
    $function_call_arguments << {}
    method(__method__).parameters.each do |key, value| $function_call_arguments[$function_call_arguments.count - 1][value.to_s] = decode_value(eval(value.to_s)) end
  end

  return marriage_data

end
