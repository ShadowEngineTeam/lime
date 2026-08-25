# PowerShell script for Windows CI builds with Visual Studio
# Used by GitLab CI for VS2026 and VS2022 builds
#
# Usage: pwsh build/gitlab-ci.ps1 <generator> <build_type> [static]
#   generator:  CMake generator (e.g., "Ninja", "Visual Studio 17 2022")
#   build_type: Release or Debug
#   static:     Optional, use "static" for static library build

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Generator,

    [Parameter(Mandatory=$true, Position=1)]
    [ValidateSet("Release", "Debug")]
    [string]$BuildType,

    [Parameter(Position=2)]
    [string]$LinkType = ""
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Paths
$SourceDir = $PSScriptRoot | Split-Path -Parent
$BuildDir = Join-Path $SourceDir "cmake-build"
$InstallDir = Join-Path $SourceDir "cmake-install"
$TestBuildDir = Join-Path $SourceDir "cmake-test-build"
$TestNoTargetBuildDir = Join-Path $SourceDir "cmake-test-no-target-build"

# vcpkg integration (if available)
$VcpkgRoot = "C:\vcpkg"
$VcpkgToolchain = Join-Path $VcpkgRoot "scripts\buildsystems\vcpkg.cmake"

function Write-Header {
    param([string]$Message)
    Write-Host ""
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host ""
}

function Initialize-Vcpkg {
    Write-Header "Initializing vcpkg Dependencies"

    if (-not (Test-Path $VcpkgRoot)) {
        Write-Host "vcpkg not found at $VcpkgRoot - skipping dependency installation"
        return
    }

    Write-Host "vcpkg found at: $VcpkgRoot"

    # Update vcpkg itself
    Push-Location $VcpkgRoot
    try {
        Write-Host "Updating vcpkg..."
        & git pull
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "vcpkg git pull failed, continuing anyway..."
        }

        # Bootstrap vcpkg if needed
        $vcpkgExe = Join-Path $VcpkgRoot "vcpkg.exe"
        if (-not (Test-Path $vcpkgExe)) {
            Write-Host "Bootstrapping vcpkg..."
            & .\bootstrap-vcpkg.bat
            if ($LASTEXITCODE -ne 0) {
                throw "vcpkg bootstrap failed with exit code $LASTEXITCODE"
            }
        }

        # Define required packages for libtiff
        # These correspond to the codec dependencies in CMakeLists.txt
        $packages = @(
            "zlib",           # Deflate codec (required)
            "libdeflate",     # Faster deflate support (optional, requires zlib)
            "libjpeg-turbo",  # JPEG codec
            "jbigkit",        # JBIG codec
            "liblzma",        # LZMA codec
            "zstd",           # ZSTD codec
            "libwebp",        # WebP codec
            "lerc"            # LERC codec
        )

        # Determine triplet based on LinkType
        if ($LinkType.ToLower() -eq "static") {
            $triplet = "x64-windows-static"
        } else {
            $triplet = "x64-windows"
        }

        Write-Host "Installing vcpkg packages for triplet: $triplet"
        foreach ($package in $packages) {
            Write-Host "  - Installing $package..."
            & .\vcpkg.exe install "${package}:${triplet}"
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Failed to install $package, continuing anyway..."
            }
        }

        Write-Host "vcpkg dependencies installation complete"
    }
    finally {
        Pop-Location
    }
}

function Initialize-VisualStudio {
    Write-Header "Initializing Visual Studio Environment"

    # Verify compiler is available
    $clPath = Get-Command cl.exe -ErrorAction SilentlyContinue
    if ($clPath) {
        Write-Host "Compiler found: $($clPath.Source)"
    } else {
        throw "cl.exe not found in PATH"
    }
}

function Invoke-CMakeConfigure {
    Write-Header "Configuring with CMake"

    # Remove old build directory if it exists
    if (Test-Path $BuildDir) {
        Write-Host "Removing existing build directory..."
        Remove-Item -Recurse -Force $BuildDir
    }

    New-Item -ItemType Directory -Path $BuildDir -Force | Out-Null
    Push-Location $BuildDir

    try {
        $cmakeArgs = @(
            "-G", $Generator,
            "-DCMAKE_BUILD_TYPE=$BuildType",
            "-DCMAKE_INSTALL_PREFIX=$InstallDir",
            "-DCMAKE_UNITY_BUILD=ON",
            "-Dfatal-warnings=ON",
            "-Dextra-warnings=ON",
            "-Dcxx-compat-warnings=ON"
        )

        # Add vcpkg toolchain if available
        if (Test-Path $VcpkgToolchain) {
            # Determine triplet based on LinkType
            if ($LinkType.ToLower() -eq "static") {
                $vcpkgTriplet = "x64-windows-static"
            } else {
                $vcpkgTriplet = "x64-windows"
            }
            Write-Host "Using vcpkg toolchain: $VcpkgToolchain (triplet: $vcpkgTriplet)"
            $cmakeArgs += "-DCMAKE_TOOLCHAIN_FILE=$VcpkgToolchain"
            $cmakeArgs += "-DVCPKG_TARGET_TRIPLET=$vcpkgTriplet"
        }

        # Static or shared build
        if ($LinkType.ToLower() -eq "static") {
            Write-Host "Building STATIC libraries"
            $cmakeArgs += "-DBUILD_SHARED_LIBS=OFF"
        } else {
            Write-Host "Building SHARED libraries"
            $cmakeArgs += "-DBUILD_SHARED_LIBS=ON"
        }

        $cmakeArgs += $SourceDir

        Write-Host "Running: cmake $($cmakeArgs -join ' ')"
        & cmake @cmakeArgs
        if ($LASTEXITCODE -ne 0) {
            throw "CMake configure failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Invoke-CMakeBuild {
    Write-Header "Building"

    Push-Location $BuildDir
    try {
        $buildArgs = @("--build", ".", "--config", $BuildType)

        Write-Host "Running: cmake $($buildArgs -join ' ')"
        & cmake @buildArgs
        if ($LASTEXITCODE -ne 0) {
            throw "CMake build failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Invoke-CMakeInstall {
    Write-Header "Installing"

    Push-Location $BuildDir
    try {
        $installArgs = @("--build", ".", "--config", $BuildType, "--target", "install")

        Write-Host "Running: cmake $($installArgs -join ' ')"
        & cmake @installArgs
        if ($LASTEXITCODE -ne 0) {
            throw "CMake install failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Invoke-CTest {
    Write-Header "Running Tests"

    Push-Location $BuildDir
    try {
        $ctestArgs = @("-V", "-C", $BuildType)

        Write-Host "Running: ctest $($ctestArgs -join ' ')"
        & ctest @ctestArgs
        if ($LASTEXITCODE -ne 0) {
            throw "CTest failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Invoke-TestProjectBuild {
    Write-Header "Building Test Project (find_package CONFIG)"

    if ($LinkType.ToLower() -eq "static") {
        Write-Host "Skipping test project build for STATIC CI/CD build"
        return
    }

    $TiffDir = Join-Path $InstallDir "lib\cmake\tiff"

    # Test with target
    if (Test-Path $TestBuildDir) {
        Remove-Item -Recurse -Force $TestBuildDir
    }
    New-Item -ItemType Directory -Path $TestBuildDir -Force | Out-Null

    Push-Location $TestBuildDir
    try {
        $testCmakeArgs = @(
            "-G", $Generator,
            "-DCMAKE_BUILD_TYPE=$BuildType",
            "-DTiff_DIR=$TiffDir",
            "-S", (Join-Path $SourceDir "build\test_cmake"),
            "-B", "."
        )

        Write-Host "Running: cmake $($testCmakeArgs -join ' ')"
        & cmake @testCmakeArgs
        if ($LASTEXITCODE -ne 0) {
            throw "Test project configure failed with exit code $LASTEXITCODE"
        }

        & cmake --build . --config $BuildType
        if ($LASTEXITCODE -ne 0) {
            throw "Test project build failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }

    # Test without target
    Write-Header "Building Test Project (no target)"

    if (Test-Path $TestNoTargetBuildDir) {
        Remove-Item -Recurse -Force $TestNoTargetBuildDir
    }
    New-Item -ItemType Directory -Path $TestNoTargetBuildDir -Force | Out-Null

    Push-Location $TestNoTargetBuildDir
    try {
        $testNoTargetArgs = @(
            "-G", $Generator,
            "-DCMAKE_BUILD_TYPE=$BuildType",
            "-DTiff_DIR=$TiffDir",
            "-S", (Join-Path $SourceDir "build\test_cmake_no_target"),
            "-B", "."
        )

        Write-Host "Running: cmake $($testNoTargetArgs -join ' ')"
        & cmake @testNoTargetArgs
        if ($LASTEXITCODE -ne 0) {
            throw "Test no-target project configure failed with exit code $LASTEXITCODE"
        }

        & cmake --build . --config $BuildType
        if ($LASTEXITCODE -ne 0) {
            throw "Test no-target project build failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

# Main execution
Write-Header "LibTIFF Windows CI Build"
Write-Host "Generator:   $Generator"
Write-Host "Build Type:  $BuildType"
Write-Host "Link Type:   $(if ($LinkType) { $LinkType } else { 'shared (default)' })"
Write-Host "Source Dir:  $SourceDir"
Write-Host "Build Dir:   $BuildDir"
Write-Host "Install Dir: $InstallDir"

Initialize-Vcpkg
Initialize-VisualStudio
Invoke-CMakeConfigure
Invoke-CMakeBuild
Invoke-CMakeInstall
Invoke-CTest
Invoke-TestProjectBuild

Write-Header "Build Completed Successfully"
