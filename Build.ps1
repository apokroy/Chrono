<#
.SYNOPSIS
    Builds and runs the Chrono tests (and optionally the examples) with the
    Delphi command-line compilers.

.DESCRIPTION
    Win32 and Win64 binaries run directly on Windows.

    Linux64 binaries need a Linux sysroot to link against. Either pass
    -LinuxSysroot (for example an SDK imported into the IDE through PAServer),
    or let the script create Build\Linux64\sysroot from a WSL distribution that
    has libc6-dev and gcc installed. Linux64 binaries are run inside WSL.

    Before that, Tests\CompileFail.dpr is compiled with the Win64 compiler to
    check that statements which must not compile (D1 + D2, Date := Now, ...) are
    rejected with the expected errors.

    Everything is written to the Build folder. Delphi is located through the
    BDS environment variable or, if it is not set, the registry (latest version).

.EXAMPLE
    .\Build.ps1
    Builds and runs the tests for Win32 and Win64.

.EXAMPLE
    .\Build.ps1 -Platform Linux64
    Builds the tests for Linux64 and runs them in WSL.

.EXAMPLE
    .\Build.ps1 -Platform Win32, Win64, Linux64 -Examples
    Builds and runs the tests and the examples for all platforms.
#>
[CmdletBinding()]
param(
    [ValidateSet('Win32', 'Win64', 'Linux64')]
    [string[]] $Platform = @('Win32', 'Win64'),

    # Also build and run the examples.
    [switch] $Examples,

    # Only build, do not run anything.
    [switch] $NoRun,

    # WSL distribution used to create the Linux sysroot and to run Linux64 binaries.
    # Defaults to the first distribution that has libc6-dev installed.
    [string] $WslDistro,

    # An existing Linux sysroot to link against instead of creating one from WSL.
    [string] $LinuxSysroot
)

$ErrorActionPreference = 'Stop'
$env:WSL_UTF8 = '1' # make wsl.exe print UTF-8 instead of UTF-16
$Root = $PSScriptRoot
$BuildDir = Join-Path $Root 'Build'

function Get-DelphiRoot {
    if ($env:BDS -and (Test-Path (Join-Path $env:BDS 'bin'))) {
        return $env:BDS.TrimEnd('\')
    }
    foreach ($hive in 'HKCU:\Software\Embarcadero\BDS', 'HKLM:\SOFTWARE\WOW6432Node\Embarcadero\BDS') {
        if (-not (Test-Path $hive)) { continue }
        $versions = Get-ChildItem $hive |
            Where-Object { $_.PSChildName -match '^\d+\.\d+$' } |
            Sort-Object { [version]$_.PSChildName } -Descending
        foreach ($version in $versions) {
            $dir = (Get-ItemProperty $version.PSPath -ErrorAction SilentlyContinue).RootDir
            if ($dir -and (Test-Path (Join-Path $dir 'bin\dcc64.exe'))) {
                return $dir.TrimEnd('\')
            }
        }
    }
    throw 'Delphi was not found. Set the BDS environment variable to the RAD Studio folder.'
}

$script:Distro = $null
function Get-WslDistro {
    if ($script:Distro) { return $script:Distro }
    if ($WslDistro) {
        $script:Distro = $WslDistro
        return $script:Distro
    }
    if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
        throw 'WSL is not available. Pass -LinuxSysroot to link, and run the Linux64 binaries on a Linux machine (-NoRun).'
    }
    $candidates = & wsl.exe --list --quiet | ForEach-Object { $_.Trim([char]0, ' ') } |
        Where-Object { $_ -and $_ -notmatch '^docker-desktop' }
    foreach ($candidate in $candidates) {
        & wsl.exe -d $candidate -- test -f /usr/lib/x86_64-linux-gnu/crt1.o 2>$null
        if ($LASTEXITCODE -eq 0) {
            $script:Distro = $candidate
            return $script:Distro
        }
    }
    throw 'No WSL distribution with libc6-dev was found. Install it there (sudo apt install libc6-dev gcc), or pass -WslDistro / -LinuxSysroot.'
}

function ConvertTo-WslPath([string] $Path) {
    $result = & wsl.exe -d (Get-WslDistro) -- wslpath -a ($Path -replace '\\', '/')
    if ($LASTEXITCODE) { throw "wslpath failed for $Path" }
    return $result.Trim()
}

function Get-LinuxSysroot {
    if ($LinuxSysroot) { return (Resolve-Path $LinuxSysroot).Path }

    $sysroot = Join-Path $BuildDir 'Linux64\sysroot'
    if (Test-Path (Join-Path $sysroot 'usr\lib\x86_64-linux-gnu\crt1.o')) { return $sysroot }

    Write-Host "Creating the Linux sysroot from WSL '$(Get-WslDistro)'..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force $sysroot | Out-Null
    $tar = Join-Path $BuildDir 'Linux64\sysroot.tar'
    & wsl.exe -d (Get-WslDistro) -- sh (ConvertTo-WslPath (Join-Path $Root 'Scripts\make-linux-sysroot.sh')) (ConvertTo-WslPath $tar) | Out-Host
    if ($LASTEXITCODE) { throw 'Creating the Linux sysroot failed.' }
    & tar.exe -xf $tar -C $sysroot
    if ($LASTEXITCODE) { throw 'Extracting the Linux sysroot failed.' }
    Remove-Item -LiteralPath $tar
    return $sysroot
}

function Build-Project([string] $Project, [string] $TargetPlatform) {
    $name = [IO.Path]::GetFileNameWithoutExtension($Project)
    $exeDir = Join-Path $BuildDir $TargetPlatform
    $dcuDir = Join-Path $exeDir "dcu\$name"
    New-Item -ItemType Directory -Force $dcuDir | Out-Null

    # Overflow and range checks on: the unit must work in projects that enable them.
    $options = @('-B', '-Q', '-$Q+', '-$R+', "-E$exeDir", "-NU$dcuDir", "-U$(Join-Path $Root 'Source')")
    switch ($TargetPlatform) {
        'Win32' {
            $compiler = 'dcc32.exe'
            $options += '-NSSystem;Winapi'
        }
        'Win64' {
            $compiler = 'dcc64.exe'
            $options += '-NSSystem;Winapi'
        }
        'Linux64' {
            $compiler = 'dcclinux64.exe'
            $sysroot = Get-LinuxSysroot
            $gcc = Get-ChildItem (Join-Path $sysroot 'usr\lib\gcc\x86_64-linux-gnu') -Directory |
                Sort-Object { [int]($_.Name -replace '\D.*$', '') } | Select-Object -Last 1
            $libPath = @(
                (Join-Path $sysroot 'usr\lib\x86_64-linux-gnu'),
                (Join-Path $sysroot 'lib\x86_64-linux-gnu'),
                $gcc.FullName,
                (Join-Path $sysroot 'lib64'),
                (Join-Path $Bds 'lib\linux64\release')
            ) -join ';'
            $options += '-NSSystem;Posix', "--syslibroot:$sysroot", "--libpath:$libPath"
        }
    }

    Write-Host "== Building $name ($TargetPlatform)" -ForegroundColor Cyan
    Push-Location (Split-Path $Project)
    try {
        & (Join-Path $Bds "bin\$compiler") @options (Split-Path $Project -Leaf) | Out-Host
    }
    finally {
        Pop-Location
    }
    if ($LASTEXITCODE) { throw "Building $name for $TargetPlatform failed." }

    $exe = Join-Path $exeDir $name
    if ($TargetPlatform -ne 'Linux64') { $exe += '.exe' }
    return $exe
}

# Compiles Tests\CompileFail.dpr as it is, which must succeed, and then once per
# "{$IFDEF SYMBOL} ... {$ENDIF} // E<code>" line with SYMBOL defined, which must
# fail with that error on that line. Returns the checks that did not.
function Test-CompileFail {
    $project = Join-Path $Root 'Tests\CompileFail.dpr'
    $outDir = Join-Path $BuildDir 'CompileFail'
    $dcuDir = Join-Path $outDir 'dcu'
    New-Item -ItemType Directory -Force $dcuDir | Out-Null
    $compiler = Join-Path $Bds 'bin\dcc64.exe'
    $options = @('-Q', "-E$outDir", "-NU$dcuDir", "-U$(Join-Path $Root 'Source')", '-NSSystem;Winapi')

    $checks = @(Select-String -LiteralPath $project -Pattern '^\s*\{\$IFDEF (\w+)\}.*\{\$ENDIF\}\s*//\s*(E\d{4})' |
        ForEach-Object {
            [pscustomobject]@{
                Symbol = $_.Matches[0].Groups[1].Value
                Error  = $_.Matches[0].Groups[2].Value
                Line   = $_.LineNumber
            }
        })

    Write-Host "== Checking that $($checks.Count) invalid statements do not compile" -ForegroundColor Cyan
    $failures = @()
    Push-Location (Split-Path $project)
    try {
        # Without any symbol the program must compile. -B also builds ChronoTypes.dcu,
        # so each check below recompiles only the program itself.
        $output = & $compiler -B @options (Split-Path $project -Leaf) | Out-String
        if ($LASTEXITCODE) {
            Write-Host $output
            return @('does not compile without checks')
        }
        foreach ($check in $checks) {
            $output = & $compiler @options "-D$($check.Symbol)" (Split-Path $project -Leaf) | Out-String
            if ($LASTEXITCODE -eq 0) {
                $failures += "$($check.Symbol) compiles"
                continue
            }
            $actual = if ($output -match "\($($check.Line)\)[^\r\n]*\b([EF]\d{4})\b") { $Matches[1] } else { 'no error on its line' }
            if ($actual -ne $check.Error) {
                Write-Host $output
                $failures += "$($check.Symbol) gives $actual instead of $($check.Error)"
            }
        }
    }
    finally {
        Pop-Location
    }
    return $failures
}

function Invoke-Binary([string] $Exe, [string] $TargetPlatform, [string[]] $Arguments = @()) {
    Write-Host "== Running $([IO.Path]::GetFileName($Exe)) ($TargetPlatform)" -ForegroundColor Cyan
    if ($TargetPlatform -eq 'Linux64') {
        & wsl.exe -d (Get-WslDistro) -- (ConvertTo-WslPath $Exe) @Arguments | Out-Host
    }
    else {
        & $Exe @Arguments | Out-Host
    }
    return $LASTEXITCODE
}

$Bds = Get-DelphiRoot
Write-Host "Delphi: $Bds"

$failed = @()
foreach ($failure in Test-CompileFail) {
    $failed += "CompileFail: $failure"
}

foreach ($target in $Platform) {
    $tests = Build-Project (Join-Path $Root 'Tests\ChronoTests.dpr') $target
    if (-not $NoRun) {
        if ((Invoke-Binary $tests $target @('--consolemode:quiet')) -ne 0) {
            $failed += "tests ($target)"
        }
    }

    if ($Examples) {
        foreach ($example in Get-ChildItem (Join-Path $Root 'Examples') -Filter '*.dpr') {
            $exe = Build-Project $example.FullName $target
            if (-not $NoRun) {
                if ((Invoke-Binary $exe $target) -ne 0) {
                    $failed += "$($example.BaseName) ($target)"
                }
            }
        }
    }
}

if ($failed) {
    Write-Host "FAILED: $($failed -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host 'All done.' -ForegroundColor Green
