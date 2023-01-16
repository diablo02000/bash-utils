# Join string
function join {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

# Parse any urls and return:
# - protocole
# - credential
# - host
# - port
# - uri
# as declarative array.
function parse_url(){
  local _url="${1}"
  local -n _output_var="${2}"

  # Extract proto from url
  read -r _proto _url <<< "$(sed -e's,^\(.*://\)\(.*\),\1 \2,g' <<< "${_url}")"

  # Extact cred if any from url
  read -r _cred _url <<< "$(sed -e's,^\(.*@\)\(.*\),\1 \2,g' <<< "${_url}")"

  # Extract host and port from url
  read -r _host_port _url <<< "$(sed -e's,^\(.*:[0-9]*\)\(.*\),\1 \2,g' <<< "${_url}")"

  # Split host and port
  IFS=':' read -r _host _port <<< "${_host_port}"

  # Return declarative array
  _output_var=([proto]="${_proto}" [credential]="${_cred/@}" [host]="${_host}" [port]="${_port}" [uri]="${_url}")
}
