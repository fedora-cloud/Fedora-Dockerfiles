function usage() {
  [ $# == 1 ] && echo "error: $1"
  echo "You must either specify the following environment variables:"
  echo "  MYSQL_USER (regex: '$mysql_identifier_regex')"
  echo "  MYSQL_PASSWORD (regex: '$mysql_password_regex')"
  echo "  MYSQL_DATABASE (regex: '$mysql_identifier_regex')"
  echo "Or the following environment variable:"
  echo "  MYSQL_ROOT_PASSWORD (regex: '$mysql_password_regex')"
  echo "Or both."
  echo "Optional Settings:"
  echo "  MYSQL_LOWER_CASE_TABLE_NAMES (default: 0)"
  echo "  MYSQL_MAX_CONNECTIONS (default: 151)"
  echo "  MYSQL_FT_MIN_WORD_LEN (default: 4)"
  echo "  MYSQL_FT_MAX_WORD_LEN (default: 20)"
  echo "  MYSQL_AIO (default: 1)"
  echo "  MYSQL_KEY_BUFFER_SIZE (default: 32M or 10% of available memory)"
  echo "  MYSQL_MAX_ALLOWED_PACKET (default: 200M)"
  echo "  MYSQL_TABLE_OPEN_CACHE (default: 400)"
  echo "  MYSQL_SORT_BUFFER_SIZE (default: 256K)"
  echo "  MYSQL_READ_BUFFER_SIZE (default: 8M or 5% of available memory)"
  echo "  MYSQL_INNODB_BUFFER_POOL_SIZE (default: 32M or 50% of available memory)"
  echo "  MYSQL_INNODB_LOG_FILE_SIZE (default: 8M or 15% of available memory)"
  echo "  MYSQL_INNODB_LOG_BUFFER_SIZE (default: 8M or 15% of available memory)"
  exit 1
}

function validate_variables() {
  # Check basic sanity of specified variables
  if [[ -v MYSQL_USER && -v MYSQL_PASSWORD ]]; then
    [[ "$MYSQL_USER"     =~ $mysql_identifier_regex ]] || usage "Invalid MySQL username"
    [ ${#MYSQL_USER} -le 16 ] || usage "MySQL username too long (maximum 16 characters)"
    [[ "$MYSQL_PASSWORD" =~ $mysql_password_regex   ]] || usage "Invalid password"
    user_specified=1
  fi

  if [ -v MYSQL_ROOT_PASSWORD ]; then
    [[ "$MYSQL_ROOT_PASSWORD" =~ $mysql_password_regex ]] || usage "Invalid root password"
    root_specified=1
  fi

  # If MYSQL_USER == "root", we have a special case
  if [[ "${user_specified:-0}" == "1" && "$MYSQL_USER" == "root" ]]; then
    if [[ "${root_specified:-0}" == "1" ]]; then
      usage "When setting MYSQL_USER to 'root' you can only set either MYSQL_PASSWORD or MYSQL_ROOT_PASSWORD"
    fi
    # We will now behave as if MYSQL_USER was not specified
    export MYSQL_ROOT_PASSWORD="$MYSQL_PASSWORD"
    export -n MYSQL_USER
    export -n MYSQL_PASSWORD
    user_specified=0
    root_specified=1
  fi

  # Either combination of user/pass/db or root password is ok
  if [[ "${user_specified:-0}" == "0" && "${root_specified:-0}" == "0" ]]; then
    usage
  fi

  # If the root user is not specified, database name is required
  if [[ "${root_specified:-0}" == "0" ]]; then
    [ -v MYSQL_DATABASE ] || usage "You need to specify database name or root password"
  fi

  if [ -v MYSQL_DATABASE ]; then
    [[ "$MYSQL_DATABASE" =~ $mysql_identifier_regex ]] || usage "Invalid database name"
    [ ${#MYSQL_DATABASE} -le 64 ] || usage "Database name too long (maximum 64 characters)"
  fi

  # Specifically check of incomplete specification
  if [[ -v MYSQL_USER || -v MYSQL_PASSWORD || -v MYSQL_DATABASE ]] && \
     [[ "${user_specified:-0}" == "0" ]]; then
    usage
  fi
}

validate_variables
