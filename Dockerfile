FROM python:3.8-alpine
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

LABEL Name="Django Girls Tutorial Environment" \
      Version="1.0"

RUN echo $'source /usr/share/bash-completion/bash_completion\n\
export HISTFILE=$HOME/.bash_history/history\n\
PS1=\'\u@\h:\w$ \''\
>> /root/.bashrc

RUN apk add --update --no-cache \
  bash \
  bash-completion \
  curl \
  gcc \
  git \
  make \
  musl-dev \
  sqlite \
  tree

RUN apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  watchman

RUN mkdir -p /etc/bash_completion.d
RUN cd /etc/bash_completion.d/ \
  && curl -SLO https://cdn.jsdelivr.net/gh/django/django@stable/2.2.x/extras/django_bash_completion

RUN pip install --no-cache-dir -U pip setuptools wheel && rm -rf /root/.cache

WORKDIR /root/src/djangogirls
COPY dev.txt dev.txt
RUN pip install --no-cache-dir -r dev.txt && rm -rf /root/.cache
