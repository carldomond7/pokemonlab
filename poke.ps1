##########Pokemon API call#############

$apiURL = "https://pokeapi.co/api/v2/pokemon-species/infernape"

#Retrieve Pokemon info
$infernape_info = Invoke-RestMethod -Uri $apiURL 

$moveset = @()
$description = @()

#Parse through pokemon info and append the abilities NAME to the moveset array
foreach($move in $infernape_info.abilities) {
    $moveset += $move.ability.name
}

foreach($des in $infernape_info.abilities)
{
    $api = $des.ability.url
    $Moveinfo = Invoke-RestMethod -Uri $api
    $parsedinfo = $Moveinfo.effect_entries[1].effect
    $description += $parsedinfo
}

$combinedarray = @()

for($i = 0; $i -lt $moveset.Count; $i++)
{
    $combinedarray += $moveset[$i]
    $combinedarray += "`n"
    $combinedarray += $description[$i]
    $combinedarray += "`n"
}

#Create unique filename
$uniqueFilename = "infernape.txt" + (Get-Date -Format "yyyyMMddHHmmss") 
$combinedarray | Set-Content -Path $uniqueFilename


#Commit and push changes to Github
git add $uniqueFilename
