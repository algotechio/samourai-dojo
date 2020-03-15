FROM    rust:1.40.0-slim

ENV     APP_DIR             /home/user
ENV     ELECTRS_URL         https://github.com/romanz/electrs/archive
ENV     ELECTRS_VERSION     0.8.2


RUN     apt-get update  && \
        apt-get install -y wget clang cmake libsnappy-dev

RUN     adduser --disabled-login --system --shell /bin/false --uid 1000 user

USER    user
WORKDIR /home/user

# Download the source code and install it
RUN     set -ex && \
        wget -qO electrs.tar.gz "$ELECTRS_URL/v$ELECTRS_VERSION.tar.gz" && \
        tar -xzvf electrs.tar.gz -C "$APP_DIR/" --strip-components 1 && \
        rm electrs.tar.gz && \
        cd "$APP_DIR" 

RUN     cargo build --release   && \
        cargo install --path .

# Make db director that will be mounted as volume and 
# Clean up unneded files (TODO: identify other files for removal)
RUN     mkdir "$APP_DIR/db" && \
        rm -r "$APP_DIR/doc"  \
              "$APP_DIR/examples" \
              "$APP_DIR/Dockerfile" \
              "$APP_DIR/src" \
              "$APP_DIR/build.rs"

# Copy restart script
COPY    ./restart.sh "$APP_DIR/restart.sh"

USER    root
RUN     chown user:nogroup "$APP_DIR/restart.sh" && \
        chmod u+x "$APP_DIR/restart.sh" 

USER    user

# Electrum RPC
EXPOSE 50001

# Prometheus monitoring
#EXPOSE 4224

STOPSIGNAL SIGINT
