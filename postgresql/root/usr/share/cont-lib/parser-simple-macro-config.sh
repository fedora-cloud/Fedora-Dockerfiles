. "/usr/share/cont-lib/parser-simple-config.sh"

__cb_macro_config ()
{
__cl_macros_config="$__cl_macros_config
$1 = $2"
}


cont_parser_simple_macro_config ()
{
    __cl_macros_config=""

    cont_parser_simple_config "$1" __cb_macro_config

    __cl_expanded_macros=$(
        echo "$__cl_macros_config" \
            | awk -f "/usr/share/cont-lib/awkscripts/simple-macros.awk"
    )

    cont_parser_simple_config __cl_expanded_macros "$2"
}
