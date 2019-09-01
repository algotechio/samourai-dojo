## Tor opens a socks proxy on port 9050 by default -- even if you don't
## configure one below. Set "SocksPort 0" if you plan to run Tor only
## as a relay, and not make any local application connections yourself.

# Socks is only available from dojonet
SocksPort 172.28.1.4:9050

## Entry policies to allow/deny SOCKS requests based on IP address.
## First entry that matches wins. If no SocksPolicy is set, we accept
## all (and only) requests that reach a SocksPort. Untrusted users who
## can access your SocksPort may be able to learn about the connections
## you make.

# Socks is only available from dojonet
SocksPolicy accept 172.28.0.0/16
SocksPolicy reject *

## The directory for keeping all the keys/etc. By default, we store
## things in $HOME/.tor on Unix, and in Application Data\tor on Windows.

DataDirectory /var/lib/tor/.tor
DataDirectoryGroupReadable 1


############### This section is just for location-hidden services ###

## Once you have configured a hidden service, you can look at the
## contents of the file ".../hidden_service/hostname" for the address
## to tell people.
## HiddenServicePort x y:z says to redirect requests on port x to the
## address y:z.

HiddenServiceDir /var/lib/tor/hsv2dojo
HiddenServiceVersion 2
HiddenServicePort 80 172.29.1.3:80

HiddenServiceDir /var/lib/tor/hsv3dojo
HiddenServiceVersion 3
HiddenServicePort 80 172.29.1.3:80

HiddenServiceDir /var/lib/tor/hsv2bitcoind
HiddenServiceVersion 2
HiddenServicePort 8333 172.28.1.5:8333
HiddenServiceDirGroupReadable 1

# Tor Bridges configuration
ClientTransportPlugin obfs4 exec /usr/local/bin/obfs4proxy

