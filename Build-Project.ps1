cd C:\localRepos\cmake_learn

$buildExists = Test-Path .\build\

if($buildExists)
{
  Remove-Item .\build\ -Recurse -Force
  New-Item -Path .\build\ -Type Directory
} else {
  New-Item -Path .\build\ -Type Directory
}

# Remove out folder
if(Test-Path .\out\)
{
  Remove-Item .\out\ -Recurse
}

# Remove install folder
if(Test-Path .\install\)
{
  Remove-Item .\install\ -Recurse
}

cd .\build\

# Check if CMake is on Path
Set-Variable -Name "isCMake" -Value ($env:Path -match "cmake")
#TODO, if not, install cmake

if($isCMake)
  {
  # Build PROJECT (Visual Basic auto detected)
  cmake ..\

  # Build
  cmake --build .

  # in .\build
  cmake --install . --prefix install --config Debug


  } else {
    Write-Host "CMake is not in the Path. Check whether is installed or not."
  }
