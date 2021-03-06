# Launching and attaching to a .NET Core process in Docker with VS Code

## In a hurry?

Instructions for trying out the sample are [here](RunTheDemo.md)

Implementing this in your project? Here's a [checklist](Checklist.md)

## Background

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

    dotnet watch publish

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

Our development image is built with `vsdbg` pre-installed. This is a remote debugging host inside the docker container,
and when launched will attach itself to a given process id.  `vsdbg` communicates with the debugging client (our IDE) via
stdin and stdout and can be accomplished relatively easily in our development environment via

    # called by vscode. Doesn't work on the command line
    docker exec -i MYPROJECT /vsdbg/vsdbg


# Further improvements

1. AngularJS artifacts should be mounted

2. Trigger browser reload if AngularJS artifacts changes

3. Debug tests in the container

4. How does this work in the context of `docker-compose`?

# Notes and references

see [notes](Notes.md)

## Try it out

Instructions for trying out the sample are [here](RunTheDemo.md)
