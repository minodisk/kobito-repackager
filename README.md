# kobito-repackager

Dockerfile for repackaging Kobito for Windows to Mac OSX or Linux.

## How to repackage

```bash:terminal
git clone git@github.com:minodisk/kobito-repackager.git
cd kobito-porter
docker-compose build
```

### OSX

```bash:terminal
docker-compose run osx
```

### Linux(x64)

```bash:terminal
docker-compose run linux_x64
```

### Linux(ia32)

```bash:terminal
docker-compose run linux_ia32
```
