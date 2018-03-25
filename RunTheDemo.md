# Trying out the sample

First we'll need to build our docker image. This is once off

    docker build src/ -t chui/demo

Then let's install some `npm` packages to watch for file system changes.

    npm install

Then we can start

    npm start

At this stage, you should be able to

1. go to the debugger on VS Code `CTRL+SHIFT+D`

2. set some breakpoints

3. and run the `Remote .NET Core Attach`

4. make some code changes, hit save, and this should
   trigger automatic recompilation and redeployment,
   all under 5 seconds
