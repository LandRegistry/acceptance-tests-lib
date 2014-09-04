
##
## Dictionary of valid characteristics
## Why? - Because we want to ensure we know what the characteristics, so we don't duplicate
## Also so we have a quick look up list to know what they are about
##

$valid_characteristics = {}

## Polygon related characteristics
$valid_characteristics['has a polygon with easement'] = 'polygon'
$valid_characteristics['has a polygon'] =               'polygon'
$valid_characteristics['has a doughnut polygon'] =      'polygon'

## Core Register related characteristics
$valid_characteristics['freehold'] =                    'core'
$valid_characteristics['leasehold'] =                   'core'
$valid_characteristics['two proprietors'] =             'core'
$valid_characteristics['one proprietor'] =              'core'

## Leasehold related characteristics
$valid_characteristics['has no lease clauses'] =        'lease'
$valid_characteristics['has lease clauses'] =           'lease'
$valid_characteristics['has a lessee name different to the proprietor'] = 'lease'
$valid_characteristics['has a lessee name matching the proprietor'] =     'lease'

## charged related characteristics
$valid_characteristics['has a charge'] =                'charge'
$valid_characteristics['has no charge restriction'] =   'charge'
$valid_characteristics['has a charge restriction'] =    'charge'

##
## How does this now work?
## On each scenario you list the characteristics of the data, this is then validated
## by the function below. If you enter an invalid characteristic then it will raise
## an exception.
##
## If all the characteristics are valid, then the function will return a hash of this values
## in the create_register.rb file this hash is called $data_characteristics
##
## An example how to use this hash is:
##
## if (!$data_characteristics['two proprietors'].nil?)
##   $regData['proprietors'][1]['full_name'] = fullName()
## else
##   $regData['proprietors'][1]['full_name'] = ''
## end


## Function to process the scenario characteristics and make them usable
def format_data_characteristics(table)

  data_characteristics = {}
  data_characteristics['types'] = {}
  data_characteristics['entities'] = {}

  if (table != '')
    table.raw.each do |value|
      if (value[0] != 'CHARACTERISTICS') then
        if (!$valid_characteristics[value[0]].nil?)
          data_characteristics['types'][$valid_characteristics[value[0]]] = true
          data_characteristics['entities'][value[0]] = true
        else
          raise "Unexpected characteristic: " + value[0]
        end
      end
    end
  end

  return data_characteristics['entities'], data_characteristics['types']

end
