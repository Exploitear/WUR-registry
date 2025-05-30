param (
    [Parameter(Mandatory = $true)]
    [string]$Command,

    [Parameter(Mandatory = $false)]
    [string]$Package
)

if ($Command -ne "install" -or !$Package) {
    Write-Host "Usage: .\wur.ps1 install <PackageName>"
    exit 1
}

$baseUrl = "https://raw.githubusercontent.com/YourUsername/wur-registry/main/manifests/$Package"
$manifestUrl = "$baseUrl/$Package.wur.yaml"
$manifestPath = ".\$Package.wur.yaml"

Write-Host "Fetching manifest..."
Invoke-WebRequest $manifestUrl -OutFile $manifestPath

$manifest = Get-Content $manifestPath | ConvertFrom-Yaml
$installer = $manifest.Installers[0]

if ($installer.InstallerType -eq "custom") {
    foreach ($file in $installer.Files) {
        Write-Host "Downloading $($file.Name)..."
        Invoke-WebRequest $file.Url -OutFile ".\$($file.Name)"
    }

    if ($installer.PostInstallScript) {
        $scriptUrl = "$baseUrl/$($installer.PostInstallScript)"
        $scriptPath = ".\$($installer.PostInstallScript)"

        Write-Host "Fetching install script..."
        Invoke-WebRequest $scriptUrl -OutFile $scriptPath

        Write-Host "Running install script..."
        & $scriptPath
    }
}
