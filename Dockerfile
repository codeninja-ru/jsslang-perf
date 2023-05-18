# syntax=docker/dockerfile:1
FROM alpine:latest

RUN apk add --no-cache \
    nodejs npm perf bash vim
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing flamegraph time


WORKDIR /usr/src/app
COPY ./package.json package.json
COPY ./package-lock.json package-lock.json
COPY ./build/jss.js .
COPY ./test test
RUN npm install --omit=dev
#RUN sysctl kernel.kptr_restrict=0
#RUN sysctl kernel.perf_event_paranoid=0

COPY <<-"EOF" profile.sh
#!/bin/sh

perf record -i -g -e cycles:u -- node --perf-basic-prof ./jss test/atom.io.css -
#perf script | egrep -v "(__libc_start|LazyCompile|v8::internal::|Builtin:|Stub:|LoadIC:|\\[unknown\\]|LoadPolymorphicIC:)" | sed 's/ LazyCompile:[*~]\\?/ /' | stackcollapse-perf > perf.out.folded
perf script | sed 's/ LazyCompile:/ /' | stackcollapse-perf > perf.out.folded
flamegraph perf.out.folded > jss-flame.svg
EOF

RUN chmod +x profile.sh
