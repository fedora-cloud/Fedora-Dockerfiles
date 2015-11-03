__cont_source_scripts()
{
    local i
    local dir="$1"
    for i in "$dir"/*.sh; do
        if test -r "$i"; then
            . "$i"
        fi
    done
}


# CONT_SOURCE_HOOKS HOOKDIR [PROJECT]
# -----------------------------------
# Source '*.sh' files from the following directories (in this order):
#   a. /usr/share/cont-layer/PROJECT/HOOK/
#   b. /usr/share/cont-volume/PROJECT/HOOK/
#
# The PROJECT argument is optional because it may be set globally by
# $CONT_PROJECT environment variable.  The need for PROJECT argument is
# basically to push people to install script into theirs own directories,
# which will allow easier multi-project containers maintenance.
cont_source_hooks()
{
    local i dir
    local hook="$1"
    local project="$CONT_PROJECT"
    local dir

    test -z "$hook" && return
    test -n "$2" && project="$2"

    for dir in /usr/share/cont-layer /usr/share/cont-volume; do
        dir="$dir/$project/$hook"
        cont_debug2 "loading scripts from $dir"
        __cont_source_scripts "$dir"
    done
}

__cont_msg()
{
    echo "$*" >&2
}


__cont_dbg()
{
    test -z "$CONT_DEBUG" && CONT_DEBUG=0
    test "$CONT_DEBUG" -lt "$1" && return
    local lvl="$1"
    shift
    __cont_msg "debug_$lvl: $*"
}


cont_info()   { __cont_msg " * $*" ; }
cont_warn()   { __cont_msg "warn: $*" ; }
cont_error()  { __cont_msg "error: $*"; }
cont_fatal()  { __cont_msg "fatal: $*"; exit 1; }
cont_debug()  { __cont_dbg 1 "$*" ; }
cont_debug2() { __cont_dbg 2 "$*" ; }
cont_debug3() { __cont_dbg 3 "$*" ; }


__cont_encode_env()
{
    local i
    for i in $1
    do
        eval local val="\$$i"
        printf ": \${%s=%q}\n" "$i" "$val"
    done
}


# CONT_STORE_ENV VARIABLES FILENAME
# ---------------------------------
# Create source-able script conditionally setting specified VARIABLES by
# inheritting the values from current environment; Create the file on path
# FILENAME.  Already existing variables will not be changed by sourcing the
# resulting script.  The argument VARIABLES expects list of space separated
# variable names.
#
# Usage:
#   $ my_var=my_value
#   $ my_var2="my value2"
#   $ cont_store_env "my_var my_var2" ~/.my-environment
#   $ cat ~/.my-environment
#   : ${my_var=my_value}
#   : ${my_var2=my\ value2}
cont_store_env()
{
    cont_debug "creating env file '$2'"
    __cont_encode_env "$1" > "$2" \
        || cont_warn "can't store environment $1 into $2 file"
}


__cont_source_scripts "/usr/share/cont-lib/autoload"
