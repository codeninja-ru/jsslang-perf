# jsslang-perf
docker image for jsslang profiling

You want to profile jsslang with perf but you don't have linux, this repo is for you

## Usage

```sh
cd jsslang
DOCKER_BUILDKIT=1 docker build -t jss -f ../jsslang-perf/Dockerfile .
docker run --name jss --privileged -td jss
docker exec -it jss bash
```

and then run ./profile.sh
