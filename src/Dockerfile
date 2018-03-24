FROM microsoft/dotnet:2.0-runtime

# install vsdbg and ps
ENV NUGET_XMLDOC_MODE skip
WORKDIR /vsdbg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip procps \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg

# require app to be mounted
WORKDIR /app
VOLUME ["/app"]
CMD dotnet CoreClrDocker.dll

