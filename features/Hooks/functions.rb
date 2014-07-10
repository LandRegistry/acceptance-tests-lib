require 'net/ssh'
require 'capybara'
require 'capybara/dsl'
require 'json'



## The function below will execute a command on the remote SSH server and then capture all responses.
def ssh_exec!(ssh, command)
  stdout_data = ""
  stderr_data = ""
  exit_code = nil
  exit_signal = nil
  ssh.open_channel do |channel|
    channel.exec(command) do |ch, success|
      unless success
        abort "FAILED: couldn't execute command (ssh.channel.exec)"
      end
      channel.on_data do |ch,data|
        stdout_data+=data
      end

      channel.on_extended_data do |ch,type,data|
        stderr_data+=data
      end

      channel.on_request("exit-status") do |ch,data|
        exit_code = data.read_long
      end

      channel.on_request("exit-signal") do |ch, data|
        exit_signal = data.read_long
      end
    end
  end
  ssh.loop
  [stdout_data, stderr_data, exit_code, exit_signal]
end


def titleNumber()

	$prefix = [*('A'..'Z')].sample(2).join
  	$title = $prefix + $title_start
	$title_start = ($title_start.to_i + 1).to_s
	return $prefix + $title_start
	
end

def appnRef()

    $abr_start = [*('A'..'Z')].sample(1).join
	$abr_end = [*('A'..'Z')].sample(3).join
	$abr_num = rand(100 .. 999).to_s
	return $abr_start + $abr_num + $abr_end

end

def firstName()
	
	if (defined?($fname)).nil? # checks whether the array already exists
		$fname = Array.new
	end

	$fname << 'Adam'
	$fname << 'Bob'
	$fname << 'Charles'
	$fname << 'Diane'
	$fname << 'Eric'
	$fname << 'Fiona'
	$fname << 'Gareth'
	$fname << 'Helen'
	$fname << 'Ingrid'
	$fname << 'Julie'
	$fname << 'Kieran'
	$fname << 'Louise'
	$fname << 'Michael'
	$fname << 'Neil'
	$fname << 'Ola'
	$fname << 'Peter'
	$fname << 'Quincy'
	$fname << 'Rachel'
	$fname << 'Sam'
	$fname << 'Terry'
	$fname << 'Una'
	$fname << 'Vicky'
	$fname << 'Will'
	$fname << 'Xavier'
	$fname << 'Yvana'
	$fname << 'Zach'

	$fname_num = rand(0 .. 25)
	
	return $fname[$fname_num]

end

def surName()
	
	if (defined?($sname)).nil? # checks whether the array already exists
		$sname = Array.new
	end

	$sname << 'Adams'
	$sname << 'Brown'
	$sname << 'Cook'
	$sname << 'Drane'
	$sname << 'Elf'
	$sname << 'Fisher'
	$sname << 'Green'
	$sname << 'Hall'
	$sname << 'Island'
	$sname << 'Jackson'
	$sname << 'King'
	$sname << 'Large'
	$sname << 'Matthews'
	$sname << 'Neilson'
	$sname << 'Onion'
	$sname << 'Parrett'
	$sname << 'Quest'
	$sname << 'Richardson'
	$sname << 'Smith'
	$sname << 'Tibbs'
	$sname << 'Usher'
	$sname << 'Vallance'
	$sname << 'Wallis'
	$sname << 'Xavier'
	$sname << 'Yankee'
	$sname << 'Zulu'

	$sname_num = rand(0 .. 25)
	
	return $sname[$sname_num]

end

def title()
	
	if (defined?($title)).nil? # checks whether the array already exists
		$title = Array.new
	end

	$title << 'Mr'
	$title << 'Mrs'
	$title << 'Miss'
	$title << 'Ms'
	$title << 'Admiral'
	$title << 'Baron'
	$title << 'Baroness'
	$title << 'Bishop'
	$title << 'Captain'
	$title << 'Doctor'
	$title << 'H.R.H.'
	$title << 'Lady'
	$title << 'Sir'
	$title << 'Lord'
	$title << 'Reverend'
	$title << ''

	$title_num = rand(0 .. 15)
	
	return $title[$title_num]

end

def decor()
	
	if (defined?($decor)).nil? # checks whether the array already exists
		$decor = Array.new
	end

	$decor << 'Junior'
	$decor << 'Senior'
	$decor << 'Also known as Superman'
	$decor << 'Baroness'
	$decor << 'BEM'
	$decor << 'MBE'
	$decor << 'Junior'
	$decor << 'Bishop of Plymouth'
	$decor << 'QC'
	$decor << 'Dame'
	$decor << 'Deceased'
	$decor << 'DCVO'
	$decor << 'Director'
	$decor << 'Surgeon'
	$decor << ''

	$decor_num = rand(0 .. 14)
	
	return $decor[$decor_num]

end

def companyName()
	
	if (defined?($cname)).nil? # checks whether the array already exists
		$cname = Array.new
	end

	$cname << 'Acme Ltd'
	$cname << 'Bang & Boom Plc'
	$cname << 'Charles Company'
	$cname << 'Danger Ltd'
	$cname << 'Elephants Co'
	$cname << 'Fresh Plc'
	$cname << 'Garden Services Ltd'
	$cname << 'Hope & Partners'
	$cname << 'Island Cove'
	$cname << 'Jones Brothers'
	$cname << 'Keep it Safe'
	$cname << 'Langage PLC'
	$cname << 'Middle Ground plc'
	$cname << 'Never Mind Ltd'
	$cname << 'Ordinary Data Group'
	$cname << 'Pass it on'
	$cname << 'Queen and Country'
	$cname << 'Ready to Go Ltd'
	$cname << 'Something Different'
	$cname << 'Taking some time'
	$cname << 'Under the covers'
	$cname << 'Very important data'
	$cname << 'Williams and Son'
	$cname << 'Xylophone'
	$cname << 'Youll & Co'
	$cname << 'Zulu PLC'

	$cname_num = rand(0 .. 25)
	
	return $cname[$cname_num]

end

def randDate()

	$rDate = Date.today-(10000*rand())
	$rDate = $rDate.strftime("%d-%^b-%Y")
	return $rDate

end


def fixSQL(sql) 

	sql = sql.gsub(/fnd_dev/, 'FND_DEV')
	sql = sql.gsub(/stg_dev/, 'STG_DEV')
	sql = sql.gsub(/acs_dev/, 'ACS_DEV')
	sql = sql.gsub(/mtd_dev/, 'MTD_DEV')

	if ($oracleEnv == 'ci') then
		sql = sql.gsub(/FND_DEV/, 'FND_CI')
		sql = sql.gsub(/STG_DEV/, 'STG_CI')
		sql = sql.gsub(/ACS_DEV/, 'ACS_CI')
		sql = sql.gsub(/MTD_DEV/, 'MTD_CI')
		sql = sql.gsub(/fnd_dev/, 'FND_CI')
		sql = sql.gsub(/stg_dev/, 'STG_CI')
		sql = sql.gsub(/acs_dev/, 'ACS_CI')
		sql = sql.gsub(/mtd_dev/, 'MTD_CI')
	end
	
	return sql
	
end