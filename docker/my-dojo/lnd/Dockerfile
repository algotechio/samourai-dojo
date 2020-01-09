FROM golang:1.13-alpine as builder

LABEL maintainer="Olaoluwa Osuntokun <laolu@lightning.engineering>"

ENV     APP_DIR             /go/src/github.com/lightningnetwork/lnd
ENV     APP_URL             https://github.com/lightningnetwork/lnd/archive
ENV     APP_VERSION         0.8.2-beta


# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV     GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN     apk add --no-cache --update alpine-sdk \
            git                                \
            make                               \
            ca-certificates                    \
            wget                           &&  \
        update-ca-certificates


WORKDIR "$APP_DIR"

# Download the source code and install it
RUN     set -ex && \
        wget -qO app.tar.gz "$APP_URL/v$APP_VERSION.tar.gz" && \
        tar -xzvf app.tar.gz -C "$APP_DIR/" --strip-components 1 && \
        rm app.tar.gz && \
        cd "$APP_DIR" 


RUN     cd "$APP_DIR" && \
        make  &&         \
        make install tags="signrpc walletrpc chainrpc invoicesrpc routerrpc"



# Start a new, final image to reduce size.
FROM    alpine as final

# Expose lnd ports (server, rpc).
EXPOSE  9735 10009

# Copy the binaries and entrypoint from the builder image.
COPY    --from=builder /go/bin/lncli /bin/
COPY    --from=builder /go/bin/lnd /bin/

# Add bash.
RUN    apk add --no-cache \
           bash

####  PENDING  ####
# Copy the entrypoint script.
#COPY   "docker/lnd/start-lnd.sh" .
#RUN    chmod +x start-lnd.sh

# Copy restart script
#COPY    ./restart.sh "$APP_DIR/restart.sh"

