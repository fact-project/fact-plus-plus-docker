# FACT++ docker

A docker image for FACT++

After cloning this repo you can do

```
$ docker build -t fact-plus-plus .
$ docker run --rm -i -t fact-plus-plus
```
`-i` is for interactive, `-t fact-plus-plus` specifiies the tag for the container,
`--rm` deletes the container after you are done.
