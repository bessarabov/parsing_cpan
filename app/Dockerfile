FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    make \
    perl \
    ;

RUN curl --silent https://raw.githubusercontent.com/miyagawa/cpanminus/1.7039/cpanm | perl - App::cpanminus
RUN cpanm Carton@v1.0.34

ADD cpanfile /app/
ADD cpanfile.snapshot /app/

WORKDIR /app
RUN carton install --deployment

# TODO
RUN apt-get install -y libdbd-mysql-perl
RUN cpanm SQL::Easy
RUN cpanm SQL::Abstract
RUN cpanm Time::ETA

ADD bin/ /app/bin/

CMD sleep 100000000
