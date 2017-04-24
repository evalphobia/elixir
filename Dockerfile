FROM erlang:18.3

RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y locales \
  && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG

RUN echo "LC_ALL=${LC_ALL}" >> /etc/default/locale \
    && echo "LANG=${LANG}" >> /etc/default/locale \
    && locale-gen ${LANG} \
    && dpkg-reconfigure -f noninteractive locales \
    && update-locale LANG=${LANG} LC_ALL=${LANG} LANGUAGE=${LANGUAGE}
