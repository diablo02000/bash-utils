# bash-utils

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
![shell-script](https://img.shields.io/badge/script-bash-121011?logo=gnu-bash&logoColor=white)

## Functions

### Join

Join several string in one separate by any delimiter.

#### man

```
join <DELIMITER> <STRING1> <STRING2> ...
```

#### return

Return a string.

#### example

```bash
# Load utils lib
source utils.sh

concat_str="$(join ";" "a" "b" "c" "d" "e")"

echo -e "${concat_str}"
```

output:

```bash
a;b;c;d;e
```

### Parse urls

Parse any urls and return declarative array with protocole, credential, host,
port and uri.

#### man

```
parse_url <URL> <ARRAY>
```

- url: Any url string (ftp(s), http(s) ...)
- array: Declarative array variable

#### return

Return declarative array with the following keys:

- proto
- host
- port
- credential
- uri

#### example

```bash
# Load utils lib
source utils.sh

# Crearte empty declarative array
declare -A parsed_url

url="https://github.com/diablo02000/bash-utils"

# Parse url and store content in parsed_url variable
parse_url "${url}" "parsed_url

echo "${parsed_url[proto]}"
echo "${parsed_url[host]}"
```

output:

```bash
https://
github.com
```
