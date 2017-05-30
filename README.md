# Docker PHP5.6 Apache

### Building 

    $ docker build -t php-server github.com/davidcostadev/docker-php56-apache.git

### Building with git clone 

    $ git clone http://github.com/davidcostadev/docker-php56-apache.git
    $ cd docker-php56-apache
    $ docker build -t php-server docker-php56-apache


## Run

    $ docker run -d -p 80:80 -v $PWD:/var/www php-server

## Run with PHPMySql and MySql

MySql

    $ docker run \
        --name mysqlserver \
        -v $PWD/mysql:/var/lib/mysql \
        -p 3306:3306 \
        -e MYSQL_ROOT_PASSWORD=123 \
        -d mysql

PHP and Apache

    $ docker run \
        --name appserver \
        -p 80:80 \
        -v $PWD:/var/www \
        --link mysqlserver:db \
        -d php-server

PHPMyAdmin

    $ docker run \
        --name myadmin \
        -d --link mysqlserver:db \
        -p 8000:80 \
        -e PMA_HOST="172.17.0.2" \
        phpmyadmin/phpmyadmin

## Extras

#### composer create-project cakephp

    $ composer create-project --prefer-dist cakephp/app davidcosta


#### composer install

    $ composer install --ignore-platform-reqs --no-scripts

