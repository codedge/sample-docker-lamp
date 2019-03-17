FROM php:7.2-fpm

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
    git \
    libfreetype6-dev \
    libcurl4-gnutls-dev \
    libpng-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    libicu-dev \
    libedit-dev \
    libxml2-dev \
    libxslt1-dev \
    libxslt1.1

RUN docker-php-ext-install \
    curl \
    json \
    pdo \
    pdo_mysql \
    mbstring \
    mysqli \
    opcache \
    intl \
    readline \
    simplexml \
    soap \
    zip \
    xsl

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-webp-dir=/usr/include/ \
    --enable-gd-native-ttf && \
    docker-php-ext-install -j$(nproc) gd

RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

ENV WORKDIR /usr/local/apache2/htdocs/
RUN mkdir -p ${WORKDIR}
RUN mkdir -p ${WORKDIR}/../logs
WORKDIR ${WORKDIR}
