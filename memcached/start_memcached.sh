#!/bin/bash

MEMCACHED_ARGS=

if [ -n "$MEMCACHED_CACHE_SIZE" ]; then
    MEMCACHED_ARGS+=" -m $MEMCACHED_CACHE_SIZE"
fi

if [ -n "$MEMCACHED_CONNECTIONS" ]; then
    MEMCACHED_ARGS+=" -c $MEMCACHED_CONNECTIONS"
fi

if [ -n "$MEMCACHED_THREADS" ]; then
    MEMCACHED_ARGS+=" -t $MEMCACHED_THREADS"
fi

exec /usr/bin/memcached -u daemon $MEMCACHED_ARGS
