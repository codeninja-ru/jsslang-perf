# jsslang-perf
docker image for jsslang profiling

You want to profile jsslang with perf but you don't have linux, this repo is for you

## Usage

```sh
cd jsslang
DOCKER_BUILDKIT=1 docker build -t jss -f ../jsslang-perf/Dockerfile .
docker run --name jss --privileged -td \
  -v $(pwd)/jss-flame.svg:/usr/src/app/jss-flame.svg \
  -v $(pwd)/build/jss.js:/usr/src/app/jss.js jss
docker exec -it jss bash
```

and then run ./profile.sh
