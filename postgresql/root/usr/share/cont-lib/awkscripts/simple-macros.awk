BEGIN {
    FS             = "=";
}

/\\$/ {
    line = line $0 ;
    line_number ++ ;
    next ;
}

$1 ~ /^[[:space:]]*[[:alpha:]][[:alnum:]_]*[[:space:]]*$/ {
    sub(/^[[:space:]]*/, "", $1);
    sub(/[[:space:]]*$/, "", $1);
    macro = $1;
    $1 = "";
    sub(/^[[:space:]]*/, "", $0);
    sub(/[[:space:]]*$/, "", $0);
    macros[macro] = $0;
    next;
}

{
    line = line $0 ;
    line = "" ;
    line_number ++ ;
    next;
}

END {
    for (replacing in macros) {
        for (replaced in macros) {
            if (replacing == replaced)
                continue;
            else
                gsub("<" replacing ">", macros[replacing], macros[replaced]);
        }
    }

    for (macro in macros) {
        print macro "=" macros[macro]
    }
}
