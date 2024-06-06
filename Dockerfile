FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
ARG TARGETARCH
WORKDIR /source

# copy and publish app and libraries
COPY api/. .
RUN dotnet nuget locals --clear all
RUN dotnet publish -c Development -a $TARGETARCH -o /app
COPY api/api_keys.txt /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

ENV \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
RUN apk add --no-cache \
    icu-data-full \
    icu-libs


WORKDIR /app
COPY --from=build /app .
# USER $APP_UID
ENTRYPOINT ["./api"]
