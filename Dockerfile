FROM  nginx:1.19.2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    wget \
    apt-transport-https \
    lsb-release ca-certificates \
    mysql-common
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update
RUN apt-get install -y php7.2-fpm php7.2 php7.2-mbstring php7.2-cli php7.2-pdo php7.2-bcmath php7.2-common php7.2-json php7.2-xml php7.2-zip php7.2-mysqlnd php7.2-gd php7.2-pdo php7.2-curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir /run/php/
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/www.conf /etc/php/7.2/fpm/pool.d/www.conf
COPY ./nginx/40-php72.sh /docker-entrypoint.d/40-php72.sh
RUN chmod 775 /docker-entrypoint.d/40-php72.sh
WORKDIR /usr/share/nginx/html