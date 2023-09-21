##########Pokemon API call#############

$apiURL = "https://pokeapi.co/api/v2/pokemon-species/infernape"

#Retrieve Pokemon info
$infernape_info = Invoke-RestMethod -Uri $apiURL -Method Get

#Create unique filename
$uniqueFilename = "infernape.txt" + (Get-Date -Format "yyyyMMddHHmmss") 
$infernape_info | Set-Content -Path $uniqueFilename


#Commit and push changes to Github
git add $uniqueFilename
