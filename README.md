# Tiddlywiki Ruby Server
A simple Ruby server for hosting TiddlyWiki

## Usage

```
Usage server.rb [options]
    -h, --help                       Print this help
    -b, --bind=ADDRESS               Bind to the address. [Default: 127.0.0.1]
    -p, --port=PORT                  Bind to the port. [Default: 5000]
    -u, --backup=BACKUP              Backup folder. [Default: bak]
    -f, --file=WIKI_FILE             The tiddlywiki file to serve and save. [Default: index.html]
    -r, --root=ROOT                  The root of the tiddlywiki server. [Default: .]
    -m, --max-backup=MAX_BACKUP      The max number of backup files. [Default: 5]
```

## Acknowledgement

This script is based on jimfoltz's [script](https://gist.github.com/jimfoltz/ee791c1bdd30ce137bc23cce826096da).
