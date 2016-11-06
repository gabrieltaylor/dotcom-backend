FROM elixir:1.3.4

RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
  inotify-tools \
  apt-transport-https

# Install node 5.x
RUN echo "deb https://deb.nodesource.com/node_5.x jessie main" > /etc/apt/sources.list.d/node.list

RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
  nodejs

# clean up
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/dotcom
WORKDIR /opt/dotcom

RUN mix local.hex --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.1.ez

CMD mix phoenix.server
