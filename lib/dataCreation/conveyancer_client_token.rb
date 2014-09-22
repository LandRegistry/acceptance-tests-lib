def generate_client_details()

  relationshipData = Hash.new()

  relationshipData['clients'] = Hash.new()
  relationshipData['clients']['full_name'] = 'Walter White'
  relationshipData['clients']['date_of_birth'] = '07-09-1959'
  relationshipData['clients']['address'] = '1 High St, London, N1 4LT'
  relationshipData['clients']['telephone'] = '01752 909 878'
  relationshipData['clients']['email'] = 'citizen@example.org'
  relationshipData['clients']['gender'] = 'M'

  if ($PERFROMANCETEST.nil?) then
    $function_call_name << 'generate_client_details'
    $function_call_data << relationshipData
  end

  return relationshipData
end


def generate_relationship_details(title_no)

  link_relationship = Hash.new()
  link_relationship['conveyancer_lrid'] = getlrid('conveyancer@example.org')
  link_relationship['title_number'] = title_no
  link_relationship['conveyancer_name'] = 'Tuco Salamanca'
  link_relationship['conveyancer_address'] = '123 Bad Place, Rottentown, ABC 123'
  link_relationship['clients'] = Array.new()
  link_relationship['clients'][0] = Hash.new()
  link_relationship['clients'][0]['lrid'] = getlrid('citizen@example.org')
  link_relationship['title_number'] = title_no
  link_relationship['task'] = 'sell'

  link_relationship['token'] = get_token_code(link_relationship)

  if ($PERFROMANCETEST.nil?) then
    $function_call_name << 'generate_relationship_details'
    $function_call_data << link_relationship
    $function_call_arguments << {}
    method(__method__).parameters.each do |key, value| $function_call_arguments[$function_call_arguments.count - 1][value.to_s] = decode_value(eval(value.to_s)) end
  end

  return link_relationship

end
