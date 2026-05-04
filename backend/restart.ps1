param(
    [Parameter(Mandatory = $true)]
    [string]$DataPath
)

Write-Host "Using data path: $DataPath"

# Stop docker containers
Write-Host "Stopping Docker containers..."
docker compose -f docker/compose.yml down

# Resolve subfolders
$meiliPath = Join-Path $DataPath "meili_data"
$postgresPath = Join-Path $DataPath "postgres_data"
$savedPagesFile = Join-Path $DataPath "saved_pages.json"

# Delete Meilisearch data
if (Test-Path $meiliPath) {
    Write-Host "Deleting Meilisearch data at $meiliPath..."
    Remove-Item -Recurse -Force $meiliPath
}
else {
    Write-Host "Meilisearch folder not found, skipping."
}

# Delete Postgres data
if (Test-Path $postgresPath) {
    Write-Host "Deleting Postgres data at $postgresPath..."
    Remove-Item -Recurse -Force $postgresPath
}
else {
    Write-Host "Postgres folder not found, skipping."
}

if (Test-Path $savedPagesFile) {
    Write-Host "Deleting saved pages file at $savedPagesFile..."
    Remove-Item -Force $savedPagesFile
}
else {
    Write-Host "saved_pages.json not found, skipping."
}

# Restart docker containers
Write-Host "Starting Docker containers..."
docker compose -f docker/compose.yml up -d

Write-Host "Done."