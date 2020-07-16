
$buildExists = Test-Path .\build\

if($buildExists)
{
  Remove-Item .\build\ -Recurse
  New-Item -Path .\build\ -Type Directory
} else {
  New-Item -Path .\build\ -Type Directory
}

cd .\build\

#Construye el proyecto VS
cmake ..\

# Construye el software
cmake --build .
