# karin-docker

Build the base image:

```bash
docker build -f base.Dockerfile -t karinjs/karin:base .
```

Build the Puppeteer image on top of the base image:

```bash
docker build -f puppetter.Dockerfile -t karinjs/karin:puppetter .
```

Use a different base image tag when needed:

```bash
docker build -f puppetter.Dockerfile \
  --build-arg BASE_IMAGE=my-karin:base \
  -t my-karin:puppetter .
```

Install extra plugin dependencies at container startup:

```bash
docker run karinjs/karin:latest --plugin @scope/plugin-a --plugin plugin-b
```
