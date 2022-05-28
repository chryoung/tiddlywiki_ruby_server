# Tiddlywiki Ruby Server
A simple Ruby server for hosting TiddlyWiki

## Usage

### On machine

1. Install Ruby
1. Install webrick gem: `gem install webrick`
1. Copy your tiddlywiki.html to index.html
1. Run `ruby server.rb`

### On Docker

```bash
docker build -t tiddlyserver:v1.0.0 .
mkdir -p ./tiddlywiki/bak
# cp your tiddlywiki.html to tiddlywiki/index.html
docker run -d \
    -p 8080:80 \
    -e MAX_BACKUP=5 \
    -v ./tiddlywiki:/data \
    tiddlyserver:v1.0.0
```

## Help

```
Usage server.rb [options]
    -h, --help                       Print this help
    -b, --bind=ADDRESS               Bind to the address. [Default: 127.0.0.1]
    -p, --port=PORT                  Bind to the port. [Default: 5000]
    -u, --backup=BACKUP              Backup folder. [Default: bak]
    -r, --root=ROOT                  The root of the tiddlywiki server. [Default: .]
    -m, --max-backup=MAX_BACKUP      The max number of backup files. [Default: 5]
```

## Acknowledgement

This script is based on jimfoltz's [script](https://gist.github.com/jimfoltz/ee791c1bdd30ce137bc23cce826096da).
