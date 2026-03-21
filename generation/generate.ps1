param()

try {
    $ErrorActionPreference = 'Stop'

    $scriptPath = $MyInvocation.MyCommand.Definition
    if (-not $scriptPath) {
        $scriptPath = $PSCommandPath
    }
    $scriptDir = Split-Path -Path $scriptPath -Parent
    if (-not (Test-Path -Path $scriptDir)) {
        Write-Error "Cannot determine script directory."
        exit 1
    }

    Write-Host "run: cd $scriptDir"
    Set-Location -Path $scriptDir

    Write-Host "run: dotnet tool restore"
    $p = Start-Process -FilePath dotnet -ArgumentList 'tool','restore' -NoNewWindow -Wait -PassThru
    if ($p.ExitCode -ne 0) {
        throw "dotnet tool restore failed, exit code: $($p.ExitCode)"
    }

    Write-Host "run: dotnet tool run ClangSharpPInvokeGenerator ""@generate.rsp"""
    $p2 = Start-Process -FilePath dotnet -ArgumentList 'tool','run','ClangSharpPInvokeGenerator','@generate.rsp' -NoNewWindow -Wait -PassThru
    if ($p2.ExitCode -ne 0) {
        throw "ClangSharpPInvokeGenerator execution failed, exit code: $($p2.ExitCode)"
    }

    Write-Host "All done."
} catch {
    Write-Error "An error occurred: $_"
    exit 1
}