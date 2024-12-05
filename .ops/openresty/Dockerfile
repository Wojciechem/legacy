# syntax=docker/dockerfile:1.11.1
FROM openresty/openresty:1.21.4.1-0-jammy

# Openresty with nginx entrypoint (envsubst)

COPY --from=nginx:stable-bookworm /docker-entrypoint.d /docker-entrypoint.d
COPY ./.ops/openresty/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
