# Hollow House — Flesh All Repos
# Canonical governance scaffolding script

$Root = "$HOME/Documents/Hollow_House"

$DiagramURL = "https://github.com/hollowhouseinstitute/Hollow_House_Institute/blob/main/diagrams/hollow_house_canonical.mmd"

$Repos = Get-ChildItem $Root -Directory | Where-Object {
    Test-Path "$($_.FullName)\.git"
}

foreach ($Repo in $Repos) {
    Write-Host "Processing $($Repo.Name)"

    $Readme = Join-Path $Repo.FullName "README.md"
    $Status = Join-Path $Repo.FullName "STATUS.md"
    $Contrib = Join-Path $Repo.FullName "CONTRIBUTING.md"

    if (!(Test-Path $Status)) {
@"
# Status

**Governance:** Hollow House Institute  
**Canonical:** Yes  
**Lifecycle:** Active
"@ | Set-Content $Status
    }

    if (!(Test-Path $Contrib)) {
@"
# Contributing

All contributions are governed by Hollow House Institute standards.

See:
- Canonical Theory
- Standards Library
"@ | Set-Content $Contrib
    }

    if (Test-Path $Readme) {
        $Content = Get-Content $Readme -Raw

        if ($Content -notmatch "Governed by Hollow House Institute") {
            $Badge = "[![Governed by Hollow House Institute](https://img.shields.io/badge/Governed%20by-Hollow%20House%20Institute-black)]($DiagramURL)"
            $Content = $Badge + "`n`n" + $Content
            Set-Content $Readme $Content
        }
    }

    Push-Location $Repo.FullName
    git add .
    git commit -m "Add governance, status, and canonical linkage" 2>$null
    Pop-Location
}

Write-Host "✔ All repositories fleshed out"
