# arm-owncloud

To start the container with default config :
```bash
docker run -d -P arm-owncloud
```

But you can also use your local datastore :
```bash
docker run -d -P -v <your local datastore>:/data arm-owncloud
```

