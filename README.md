# Launching and attaching to a .NET Core process in Docker with VS Code

I'm currently working with a project that has multiple microservices
running in Docker containers. I found working with Visual Studio extremely
clumsy. The `docker-compose` extension to Visual Studio is slow, and can
cause docker images to be recreated. Even though the file system layers are cached,
it still adds seconds for each image.

This where I found that VS Code's development story is somewhat better, and
can be fine-tuned to give better development experience.

There are a few moving parts and questions to this story.

1. How do we build our binary? Do we build it in the container, or do we build it in our host?

2. How do we deploy it into the container? Do we use a volume mount, or do we build our image each time?

3. How do we start our process? Do we `docker exec` each time, or should we `docker run` and run a new container?

4. How do we attach to the process to debug? How do we find the container id, and the process id?

A lot of questions and decisions!!

## 1 Building the binary

We want this to be fast, and ideally automatic. To me this means running the buid on the host,
and using docker watch.

The only officially supported way to prepare an application for deployment is via `dotnet publish` (see [docs.microsoft.com](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish?tabs=netcore2x) )

So our command line on the host should look like:

    docker watch publish

## 2 Deploying the binary

We have two choices here. We can copy the binaries from `dotnet publish` when we build
our docker images, or we can volume mount it. To optimise for developer happiness, we can shave off seconds if we don't rebuild images.

    # once off
    docker build . -t MYPROJECT

## 3 Starting process

We can reuse a container, and launch a process with `docker exec dotnet MyProject.dll`
or we can launch a new container each time.

Technically, there is not a great deal of difference. Launching containers are cheap since they _are_ processes.

    docker run --name MYPROJECT --rm -v bin/Debug/netcoreapp2.0:/app MYPROJECT

Note we name our container, and _remove_ it when the container terminates.

## 4 attaching to a process for debugging

Our development image is built with `vsdbg` installed on `/vsdbg/vsdbg`. This is remote debugging host inside the docker container, and when launched will attach
to a process id.  `vsdbg` communicates with the debugging client (our IDE) via stdin and stdout. This can be accomplished relatively easily in our development environment via

    # called by vscode. Doesn't work on the command line
    docker exec -i MYPROJECT /vsdbg/vsdbg

# Trying out the sample

First we'll need to build our docker image. This is once off

    docker build src/ -t chui/demo

Then we run a little watch window publishing the .NET Core project
each time the source changes

    cd src
    dotnet watch publish -o out

Next we run another terminal, and launch the docker image

    docker run -it --name demo --rm -v "${pwd}\src\out:/app" chui/demo

At this stage, you should be able to

1. go to the debugger on VS Code `CTRL+SHIFT+D`

2. set some breakpoints

3. and run the `Remote .NET Core Attach`
