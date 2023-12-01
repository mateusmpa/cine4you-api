FROM ruby:3.2.2-slim
RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential libpq-dev graphviz
ENV INSTALL_PATH /cine4you-api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile ./
ENV BUNDLE_PATH /box
COPY . .
