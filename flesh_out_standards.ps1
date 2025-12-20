# ================================
# Hollow House – Standards Library Flesher
# ================================

$RepoName = "hollowhouse-standards-library"
$BasePath = "$HOME\Documents\Hollow_House\$RepoName"

if (!(Test-Path $BasePath)) {
    Write-Error "Repo not found: $BasePath"
    exit 1
}

Set-Location $BasePath

Write-Host "Fleshing out $RepoName..." -ForegroundColor Cyan

# ---------- README.md ----------
@"
# Hollow House Standards Library

## Canonical Role
This repository defines **formal standards, schemas, and operational constraints**
used across all Hollow House research, datasets, tools, and publications.

All downstream repositories MUST conform to the standards defined here.

## Governance
**Governed by:** Hollow House Institute  
**Authority Level:** Canonical  
**Change Control:** Institute-reviewed only

## Scope
This repository includes:
- Dataset schemas
- Operational standards
- Ethical constraints
- Timeline consistency rules
- Contractual / ritual formalism

## Relationship to Other Repositories
- Research repos IMPLEMENT these standards
- Dataset repos VALIDATE against these schemas
- Tools repos ENFORCE these constraints

## Directory Structure
- /docs — human-readable standards
- /legal — licenses and binding terms
- /assets — diagrams and reference material

This repository is normative.
"@ | Set-Content README.md -Encoding UTF8

# ---------- STATUS.md ----------
@"
# Repository Status

**Status:** ACTIVE  
**Maturity:** STABLE  
**Canonical:** YES

## Governance
This repository is governed by the Hollow House Institute.
All changes require review and approval.

## Change Policy
- Backwards compatibility preferred
- Breaking changes require versioning
- All updates must document downstream impact
"@ | Set-Content STATUS.md -Encoding UTF8

# ---------- CONTRIBUTING.md ----------
@"
# Contributing Guidelines

## Scope of Contributions
Contributions must relate to:
- Standards
- Schemas
- Governance mechanisms

## Restrictions
- No speculative theory
- No implementation code
- No dataset content

## Review Process
1. Proposal submission
2. Institute review
3. Formal approval
4. Merge to main
"@ | Set-Content CONTRIBUTING.md -Encoding UTF8

# ---------- DESCRIPTION.md ----------
@"
Canonical standards, schemas, and governance framework for Hollow House research,
datasets, and operational systems.
"@ | Set-Content DESCRIPTION.md -Encoding UTF8

Write-Host "Files written successfully." -ForegroundColor Green

# ---------- Git commit (if applicable) ----------
if (Test-Path ".git") {
    git add README.md STATUS.md CONTRIBUTING.md DESCRIPTION.md
    git commit -m "Flesh out canonical standards documentation"
    Write-Host "Committed to git." -ForegroundColor Green
} else {
    Write-Host "Not a git repo – files created only." -ForegroundColor Yellow
}
