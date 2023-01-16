# Join string
function join {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

# Parse any urls and return:
# - scheme
# - credential
# - host
# - port
# - uri
# as declarative array.
function parse_url(){
  local _url="${1}"
  local -n _output_var="${2}"
  local _scheme _cred _host_port

  # Extract scheme from url
  _scheme="$(sed -e 's,^\(.*://\).*,\1,g' <<< "${_url}")"
  _url="${_url/$_scheme}" # Remove scheme from url
  _scheme="${_scheme/:\/\/}" # Remove :// from scheme

  # Extact credential if present from url
  if grep -Eq '@[a-zA-Z]' <<< "${_url}";
  then
    IFS='@' read -r _cred _url <<< "${_url}"
  fi

  # Extract host and port from url
  _host_port="$(cut -d/ -f1  <<< "${_url}")"
  _url="${_url/$_host_port}" # Remove host and port pattern from url.

  # Split host and port
  IFS=':' read -r _host _port <<< "${_host_port}"

  # Return declarative array
  _output_var=([scheme]="${_scheme}" [credential]="${_cred}" [host]="${_host}" [port]="${_port}" [uri]="${_url}")
}
