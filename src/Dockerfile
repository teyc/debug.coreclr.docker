FROM microsoft/dotnet:2.0-sdk

# install vsdbg
ENV NUGET_XMLDOC_MODE skip
WORKDIR /vsdbg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg

# restore watcher
WORKDIR /app
COPY CoreClrDocker.csproj .
RUN dotnet restore

# require app to be mounted
VOLUME ["/app"]

ENTRYPOINT ["dotnet", "watch", "run"]