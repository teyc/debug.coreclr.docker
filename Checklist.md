# Checklist

1. Copy the `Dockerfile`

2. Alter the last line `CMD dotnet CoreClrDocker.dll`

3. Copy `package.json` sections `watch` and `scripts`

4. Copy `scripts\Restart-Docker.ps1`

5. Change `$image` and `$container` names

6. Copy `.vscode\launch.json`, specifically the `Remote .NET Core Attach` section

