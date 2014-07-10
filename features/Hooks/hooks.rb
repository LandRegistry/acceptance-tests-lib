Before do


end


Before do | scenario |  
	
  
	$title_start = ENV['TITLEID'] || rand(999999).to_s
	$Env = ENV['DEVENV'] || 'DEV'
	#$Env = ENV['PREVIEWENV'] || 'PREVIEW'
	
	#Defines the URL to use dependent on environment being tested
	$URL = ""
	puts "environment is " + $Env
	if $Env == "DEV" then
		$URL = "http://localhost:5002"
	end
	if $Env == "PREVIEW" then
		$URL = "http://lr-system-of-record.herokuapp.com"
	end
	#Connect to PostgreSQL		
	puts 'Connecting to Titles DB';		
	#$postgres = RDBI.connect :ODBC, :db => $Env

	
	
end



After do | scenario |  
	
end 

AfterStep do |scenario|
  
end



