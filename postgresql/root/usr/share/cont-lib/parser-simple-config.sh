. "/usr/share/cont-lib/cont-lib.sh"

# SEMICOLON_SPLIT VAR
# -------------------
# Split the contents of string variable VAR into list of strings (on separate
# line), each of those strings will be printed to standard output.  The ';' and
# newline characters are used as split separators.  You can use quadrigraph @.,@
# for ';' character not splitting the VAR (and use @&t@ to expand into empty
# string).  More info about quadrigraphs may be found in autoconf info page.
cont_semicolon_split()
{
    eval set -- "\"\$$1\""
    test x = x"$1" && return 0

    echo "$1" \
        | sed \
            -e 's/[[:space:]]*;[[:space:]]*/\n/g' \
            -e 's/^[[:space:]]*//g' \
            -e 's/\([^\\]\)[[:space:]]*$/\1/g' \
        | sed \
            -e 's|@.,@|;|g' \
            -e 's|@&t@||g'
}

# CONT_PARSER_SIMPLE_CONFIG CONFIG_VAR CALLBACK [ARGS]
# ----------------------------------------------------
# Parse contents of variable of name CONFIG_VAR, call CALLBACK function (or
# command) for each parsed configuration option.
#
# The format of configuration file is:
#
#   <key> = <value> [; ...]
#
# Content of <key> is not limited, but keep it sane please (lets say we support
# the C syntax of identifiers).  The <value> must be single-line string.  Should
# the <value> contain ';' or '\' character, it must be escaped by '\'.
#
# The semantics of CALLBACK you *must* provide is:
#
#   CALLBACK KEY VALUE [ARGS]
#   -------------------------
#   KEY and VALUE are strings with parsed result.  ARGS is additional payload
#   you may provide during CONTAINER_SIMPLE_CONFIG_PARSER call.
#
# Example of usage:
#
#   $ cat script.sh
#   callback()
#   {
#       local var="$1" val="$2"
#       shift 2
#       test -n "$*" && local payload=" [$*]"
#       echo "$var=$val$payload"
#   }
#   config='URL = "http://example.com"; semicolon = "@.,@"'
#   cont_parser_simple_config config callback additional data
#
#   $ ./script
#   URL="http://example.com" [additional data]
#   semicolon=";" [additional data]
cont_parser_simple_config()
{
    local conf_var="$1"
    local callback="$2"
    shift 2

    while read line; do
        test -z "$line" && continue
        if [[ $line =~ ^([^[:space:]]+)[[:space:]]*=[[:space:]]*(.*)$ ]]
        then
            local k="${BASH_REMATCH[1]}" v="${BASH_REMATCH[2]}"
            cont_debug3 "calling callback with: $k = $v"
            "$callback" "$k" "$v" "$@" || {
                cont_error "$FUNCNAME: callback failed"
                return 1
            }
        else
            cont_warn "wrong config: $line"
        fi
    done < <(cont_semicolon_split "$conf_var")

    return 0
}
