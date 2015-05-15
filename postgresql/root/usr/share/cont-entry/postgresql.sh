# As we tend to support systemd in container, we need to let systemd-driven
# service know about container-runtime environment variables.  We do that via
# ~/.cont-SERVICE-environment (sourceable)  shell script.

# Users are really discouraged to use 'POSTGRESQL_ADMIN_PASSWORD', but its
# still needed for convenience.  We remove the environment file before
# the PostgreSQL server starts anyway.

test x1 = x"$$" \
    && test x0 = x"$PPID" \
    && test x0 = x"$UID" \
    || return 0

__env_vars="
    CONT_DEBUG
    POSTGRESQL_ADMIN_PASSWORD
    POSTGRESQL_CONFIG
    POSTGRESQL_CONTAINER_OPTS
    POSTGRESQL_DATABASE
    POSTGRESQL_PASSWORD
    POSTGRESQL_USER
"

cont_store_env "$__env_vars" "/var/lib/pgsql/.cont-postgresql-environment"

unset __env_vars
