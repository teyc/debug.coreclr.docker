# Work in progress

`.\scripts\Watch-Source.ps1` publishes each time the sources change

`.\scripts\Run-Docker.ps1` runs docker in an infinite loop

`.\scripts\Watch-OutDirectory.ps1` stops docker every time published output changes

You'll have to run all three in tandem. It takes about <strike>15 seconds to see change, which is unacceptably slow</strike>. Using `docker kill`, restarts take about 5 seconds.



