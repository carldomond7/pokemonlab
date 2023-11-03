##########Pokemon API call#############
#Retrieve Pokemon info
#Parse through pokemon info and append the abilities NAME to the moveset array

$inf = Invoke-RestMethod "https://pokeapi.co/api/v2/pokemon/staraptor" 

$moveset = @()
$description = @()
foreach ($move in $inf.abilities) {
    $moveset += $move.ability.name 
}

foreach ($des in $inf.abilities)
{
    $api = $des.ability.url 
    $response = Invoke-RestMethod -Uri $api
    $engresponse = $response.effect_entries[1].effect 
    $description += $engresponse
}

#Write-Host "$($moveset)"
#Write-Host "$($description)"
$combinedarray = @()

#For loop to create finalized array
for($i = 0; $i -lt $moveset.Count; $i++)
{
    #Adding the particular move at this index to the array
    $combinedarray += $moveset[$i]
    #Creating a new line after that move
    $combinedarray += "`n"
    #Adding corresponding description to that move 
    $combinedarray += $description[$i]
    $combinedarray += "`n"
}


#Create unique filename
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$uniqueFilename = "staraptor_$timestamp.txt"
$combinedarray | Set-Content -Path $uniqueFilename


if (Test-Path -Path $uniqueFilename) {
    Write-Host "File created successfully."
    Write-Host $env:SECRET_TOKEN
} else {
    Write-Host "File creation failed or the file does not exist."
}

git add $uniqueFilename


