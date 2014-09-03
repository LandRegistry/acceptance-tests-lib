def genRegDetails_tenure()
  if (!$data_characteristics['leasehold'].nil?)
    data = 'Leasehold'
  else
    data = 'Freehold'
  end

  return data

end



def generate_lease_information()

  if $regData['property']['tenure'] =='Leasehold' then
    #build up the leasehold structure



    $regData['leases'] = Array.new()
    $regData['leases'][0] = Hash.new()
    $regData['leases'][0]['lease_term'] = rand(7..999)

    if (!$data_characteristics['has no lease clauses'].nil?)

      $regData['leases'][0]['lease_easements'] = false
      $regData['leases'][0]['title_registered'] = false
      $regData['leases'][0]['alienation_clause'] = false

    else

      $regData['leases'][0]['lease_easements'] = true
      $regData['leases'][0]['title_registered'] = true
      $regData['leases'][0]['alienation_clause'] = true

    end

    if (!$data_characteristics['has a lessee name different to the proprietor'].nil?)
      $regData['leases'][0]['lessee_name'] = fullName() + 's'
    else
      $regData['leases'][0]['lessee_name'] = $regData['proprietors'][0]['full_name']
    end

    $regData['leases'][0]['lessor_name'] = fullName()

    $regData['leases'][0]['lease_date'] = Date.today.prev_day.strftime("%Y-%m-%d")
    $regData['leases'][0]['lease_from'] = Date.today.prev_day.strftime("%Y-%m-%d")

  end

end



def generate_charge_information()

  if (!$data_characteristics['has a charge'].nil?)

    $regData['charges'] = Array.new()
    $regData['charges'][0] = Hash.new()
    $regData['charges'][0]['charge_date'] = '2014-08-11'
    $regData['charges'][0]['chargee_address'] = '12 Test Street, London, SE1 33S'
    $regData['charges'][0]['chargee_name'] = 'Test Bank'
    $regData['charges'][0]['chargee_registration_number'] = '1234567'

    if (!$data_characteristics['has no charge restriction'].nil?)
      $regData['charges'][0]['charges-0-has_restriction'] = false
    else
      $regData['charges'][0]['charges-0-has_restriction'] = true
    end

  end

end

def generate_title_extent_information()

  if ($data_characteristics_types['polygon']) then
    $polycount = 0
    $easementCount = 0

    $regData['extent'] = genenerate_title_extent2($data_characteristics)

    if ($easementCount > 0)

      $regData['easements'] = Array.new()
      $regData['easements'] = []
      $regData['easements'][0] = {}
      $regData['easements'][0]['easement_geometry'] = genenerate_title_easement2($data_characteristics)
      $regData['easements'][0]['easement_description'] = 'Easement Description'

    end

  else
    $regData['extent'] = genenerate_title_extent2({'polygon' => true})
  end

end
