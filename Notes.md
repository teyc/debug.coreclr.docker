# Notes on working with docker

## Most images don't come with unzip

`apt-get update` is overkill (it'll grab 9MB of data just to work out how to install `unzip`)

    curl http://http.us.debian.org/debian/pool/main/u/unzip/unzip_6.0-21_amd64.deb -o unzip.deb
    curl http://http.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_amd64.deb -o libbz2.deb
    dpkg -i libbz2.deb
    dpkg -i unzip.deb

## Most images don't come with `ps`

`apt-get update` is overkill (it'll grab 9MB of data just to work out how to install `procps`)

Instead:

    curl http://http.us.debian.org/debian/pool/main/p/procps/procps_3.3.12-3_amd64.deb -o procps.deb
    curl http://http.us.debian.org/debian/pool/main/p/procps/libprocps6_3.3.12-3_amd64.deb -o libprocps.deb
    curl http://http.us.debian.org/debian/pool/main/n/ncurses/libncurses5_6.0+20161126-1+deb9u2_amd64.deb -o libncurses5.deb
    dpkg -i libncurses5.deb
    dpkg -i libprocps.deb
    dpkg -i procps.deb

## `Visual Studio uses  `vsdbg interpreter=vscode`

Visual Studio runs `dotnet` in an existing container, and points it to the build output

    root@7fb8f9e5ee2a:/app# ps -x
    PID TTY      STAT   TIME COMMAND
        1 ?        Ss     0:00 tail -f /dev/null
        7 ?        SLsl   0:06 /remote_debugger/vsdbg --interpreter=vscode
        14 ?        SLl    0:04 /usr/bin/dotnet --additionalProbingPath /root/.nuget/packages --additionalProbingPath /root/.nuget/fallbackpackages --additionalProbingPath /root/.nuget/fallbackpackages2 bin/Debug/netcoreapp2.0/DevicePortal.Gateway.dll
        59 pts/0    Ss     0:00 /bin/bash
    180 pts/0    R+     0:00 ps -x