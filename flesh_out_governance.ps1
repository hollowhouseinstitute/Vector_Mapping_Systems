$CanonicalTheoryURL = "https://github.com/hollowhouseinstitute/hollowhouse-research-papers/blob/main/Research_Papers/1_THEORY/canonical_theory.md"

$GovernanceBadge = @"
![Governed by Hollow House Institute](https://img.shields.io/badge/Governed%20by-Hollow%20House%20Institute-black)
![Canonical Theory](https://img.shields.io/badge/Canonical-Theory-critical)
"@

$GovernanceSection = @"
## Canonical Governance

This repository is governed by the **Hollow House Institute Canonical Theory**.

Canonical Theory:
→ $CanonicalTheoryURL
"@

$StatusTemplate = @"
# Repository Status

**Status:** Active  
**Governed by:** Hollow House Institute  
**Canonical Theory:** $CanonicalTheoryURL
"@

$ContributingTemplate = @"
# Contributing

All contributions must align with the Hollow House Institute Canonical Theory.

Before submitting changes:
- Read the Canonical Theory
- Preserve structural integrity
- Avoid interpretive drift

Canonical reference:
$CanonicalTheoryURL
"@

Get-ChildItem -Directory | ForEach-Object {
    $Repo = $_.FullName
    $Name = $_.Name

    if (-not (Test-Path (Join-Path $Repo ".git"))) {
        Write-Host "Skipping (not a git repo): $Name"
        return
    }

    Write-Host "`nProcessing repo: $Name"

    $Readme = Join-Path $Repo "README.md"
    $Status = Join-Path $Repo "STATUS.md"
    $Contrib = Join-Path $Repo "CONTRIBUTING.md"

    if (-not (Test-Path $Readme)) {
        "# $Name`n`n$GovernanceBadge`n$GovernanceSection" | Set-Content $Readme
    } else {
        $content = Get-Content $Readme -Raw
        if ($content -notmatch "Canonical Theory") {
            Add-Content $Readme "`n$GovernanceBadge`n$GovernanceSection"
        }
    }

    if (-not (Test-Path $Status)) {
        $StatusTemplate | Set-Content $Status
    }

    if (-not (Test-Path $Contrib)) {
        $ContributingTemplate | Set-Content $Contrib
    }

    Push-Location $Repo
    git add README.md STATUS.md CONTRIBUTING.md 2>$null
    git commit -m "Add canonical governance scaffolding" 2>$null
    Pop-Location
}
