

## Powershell execution policy

Powershell must be configure to run scripts as follows

```powershell
Set-ExecutionPolicy RemoteSigned
```

Afterwards, to restrict powershell scripts again use:


```powershell
Set-ExecutionPolicy Restricted
```
