
$buildExists = Test-Path .\build\

if($buildExists)
{
  Remove-Item .\build\ -Recurse -Force
  Remove-Item .\out\ -Recurse -Force
  New-Item -Path .\build\ -Type Directory
} else {
  New-Item -Path .\build\ -Type Directory
}

cd .\build\

# Check if CMake is on Path
Set-Variable -Name "isCMake" -Value ($env:Path -match "cmake")
#TODO, if not, install cmake

if($isCMake)
  {
  #Construye el proyecto VS
  cmake ..\

  # Construye el software
  cmake --build .
  } else {
    Write-Host "CMake is not in the Path. Check whether is installed or not."
  }
