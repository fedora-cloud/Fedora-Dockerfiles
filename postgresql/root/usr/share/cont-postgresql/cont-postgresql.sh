. "/usr/share/cont-lib/cont-lib.sh"
. "/usr/share/cont-lib/parser-simple-config.sh"


pgcont_opt()
{
    echo "${__pgcont_config[$1]}"
}


pgcont_opt_check()
{
    test x"${__pgcont_config[$1]}" = x"$2"
}


__pgcont_cb_opts()
{
    __pgcont_config[$1]=$2
}


__pgcont_load_config()
{
    test -r "/var/lib/pgsql/.cont-postgresql-environment" \
        && . /var/lib/pgsql/.cont-postgresql-environment

    local config="\
        assert_external_data    = true ;
        clear_pgdata_pidfile    = false ;

        pgdata                  = /var/lib/pgsql/data ;
        pghba                   = /var/lib/pgsql/data/pg_hba.conf ;
        pghome                  = /var/lib/pgsql ;
        pgconf                  = /var/lib/pgsql/data/postgresql.conf ;
        pgcontconf              = /var/lib/pgsql/data/postgresql-container.conf ;
        pidfile                 = /var/lib/pgsql/data/postmaster.pid  ;
        $POSTGRESQL_CONTAINER_OPTS
    "

    cont_parser_simple_config config __pgcont_cb_opts
}


pgcont_config_init()
{
    local pgconf="$(pgcont_opt pgconf)"

    test -f "$pgconf" || {
        cont_error "$(pgcont_opt pgdata) dir does not seem to be initialized"
        return 1
    }

    # Make sure that the 'pgcontconf' exists after pgcont_config_init.
    touch "$(pgcont_opt pgcontconf)"

    local msg="Container specific configuration"

    # Already initialized?
    grep -q "$msg" "$pgconf" && return 0

    # No inclusion specified yet.
    cat >> "$pgconf" <<EOF
# $msg
include '$(pgcont_opt pgcontconf)'
EOF
}


# CONT_POSTGRESQL_CONFIG_SET CONFIG_OPTION VALUE
# ----------------------------------------------
pgcont_config_set_option()
{
    local cf="$(pgcont_opt pgcontconf)"
    test -f "$cf" || {
        pgcont_config_init || return 1
    }

    local key="$1"
    local value="$2"
    local hit=false

    test "$#" -lt 2 && {
        cont_error "not enough parameters for '$FUNCNAME'"
        return 1
    }

    cp "$cf"{,~} || {
        cont_error "can't write into '$cf~' file"
        return 1
    }

    while read line; do
        if [[ $line =~ ^(#[[:space:]]*)?$key[[:space:]]*= ]]; then
            if $hit; then
                cont_warn "multiple occurences of '$key' in '$cf'," \
                          "only the first is adjusted and others are commented"
                continue
            fi
            echo "$key = $value"
            hit=:
        else
            echo "$line"
        fi
    done < "$cf~" > "$cf" || {
        cont_error "can't configure '$cf'"
        return 1
    }

    $hit || echo "$key = $value" >> "$cf" || {
        cont_error "can't append to '$cf'"
        return 1
    }

    return 0
}


__pgcont_config_cb_parse_var()
{
    local key="$1"
    local value="$2"
    pgcont_config_set_option "$key" "$value"
}


pgcont_config_use_var()
{
    cont_parser_simple_config "$1" __pgcont_config_cb_parse_var \
        || return 1
}


pgcont_check_external_storage()
{
    local pgdata=$(pgcont_opt pgdata)

    cont_debug3 "working with: $pgdata"

    if pgcont_opt_check assert_external_data false; then
        /usr/bin/rm -rf "$pgdata/.container_internal"
        return 0
    fi

    local msg="\
You plan to run the data directory '$pgdata' from container.  Please run the
image like 'docker run -v YOUR_DIR:$pgdata'.  Or use the
'assert_external_data = false' option in POSTGRESQL_CONTAINER_OPTS.  For more
info see the 'container-usage' command output."

    test -f "$pgdata/.container_internal" \
        && cont_error "$msg" \
        && return 1

    return 0
}


pgcont_cleanup_environment()
{
    unset POSTGRESQL_ADMIN_PASSWORD \
          POSTGRESQL_CONFIG \
          POSTGRESQL_CONTAINER_OPTS \
          POSTGRESQL_DATABASE \
          POSTGRESQL_PASSWORD \
          POSTGRESQL_USER
}


# PGCONT_SERVER_START_LOCAL
# -------------------------
# Start postgresql server against /var/lib/pgsql/data
# in background listening only on localhost.
pgcont_server_start_local()
{
    pg_ctl -D "/var/lib/pgsql/data" -w start -o '-h localhost' "$@"
}


# PGCONT_SERVER_STOP
# ------------------
# Stop background postgres process running against
# /var/lib/pgsql/data.
pgcont_server_stop()
{
    pg_ctl -D "/var/lib/pgsql/data" stop
}


__pgcont_select_user()
{
    psql -d postgres --set=user="$1" -tA \
        <<<"SELECT 1 FROM pg_roles WHERE rolname = :'user'"
}


__pgcont_passwd()
{
    psql -d postgres --set=user="$1" --set=pass="$2" -tA \
        <<<"ALTER USER :\"user\" WITH ENCRYPTED PASSWORD :'pass';"
}


# PGCONT_CREATE_SIMPLE_DB DBNAME DBUSER [DBPASS]
# ----------------------------------------------
# Requires running server!
pgcont_create_simple_db()
(
    set -e
    db="$1" user="$2" pass="$3"
    test -z "$(__pgcont_select_user "$user")" && createuser "$user" -D
    test -n "$pass" && __pgcont_passwd "$user" "$pass" >/dev/null
    createdb --owner "$user" "$db"
)


declare -A __pgcont_config
__pgcont_load_config
