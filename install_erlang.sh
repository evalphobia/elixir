#!/bin/bash
# credit: https://github.com/codeship/scripts/blob/master/languages/erlang.sh

ERLANG_VERSION=${ERLANG_VERSION:="18.3"}
ERLANG_PATH=${ERLANG_PATH:=$HOME/erlang}
CACHE_PATH=${CACHE_PATH:=$HOME/cache}
CACHED_DOWNLOAD="${CACHE_PATH}/erlang-OTP-${ERLANG_VERSION}.tar.gz"

# credit: https://unix.stackexchange.com/questions/101080/realpath-command-not-found
realpath() {
    f=$@;
    if [ -d "$f" ]; then
        base="";
        dir="$f";
    else
        base="/$(basename "$f")";
        dir=$(dirname "$f");
    fi;
    dir=$(cd "$dir" && /bin/pwd);
    echo "$dir$base"
}

mkdir -p "${CACHE_PATH}"
mkdir -p "${ERLANG_PATH}"
ERLANG_PATH=$(realpath "${ERLANG_PATH}")

curl -L -o "${CACHED_DOWNLOAD}" "https://s3.amazonaws.com/heroku-buildpack-elixir/erlang/cedar-14/OTP-${ERLANG_VERSION}.tar.gz"
tar -xaf "${CACHED_DOWNLOAD}" --strip-components=1 --directory "${ERLANG_PATH}"
"${ERLANG_PATH}/Install" -minimal "${ERLANG_PATH}"

export PATH="${ERLANG_PATH}/bin:${PATH}"
erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), erlang:display(erlang:binary_to_list(Version)), halt().' -noshell | grep "${ERLANG_VERSION}"
