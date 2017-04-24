#!/bin/bash
# credit: http://qiita.com/seizans/items/92a0ccc8ce0559491ec4

set -eux

# Install Erlang
export ERLANG_VERSION=${ERLANG_VERSION:-18.3}
export ERLANG_PATH="$HOME/otp-$ERLANG_VERSION"
if [ ! -e $ERLANG_PATH/bin/erl ]; then
  curl -O http://erlang.org/download/otp_src_$ERLANG_VERSION.tar.gz
  tar xzf otp_src_$ERLANG_VERSION.tar.gz
  cd otp_src_$ERLANG_VERSION
  ./configure --prefix=$ERLANG_PATH \
              --disable-native-libs \
              --disable-sctp \
              --enable-dirty-schedulers \
              --enable-hipe \
              --enable-kernel-poll \
              --enable-m64-build \
              --enable-smp-support \
              --enable-threads \
              --without-javac
  make
  make install
fi
export PATH="$ERLANG_PATH/bin:$PATH"
