# Docker PHP5.6 Apache

### building 

docker build -t php-server github.com/davidcostadev/docker-php56-apache.git

### building with clone 

git clone http://github.com/davidcostadev/docker-php56-apache.git
docker build -t php-server docker-php56-apache


## Run

docker run -d -p 80:80 -v $PWD:/var/www php-server


## Extras

### composer create-project cakephp
docker run --rm --interactive --tty --volume $PWD:/app composer create-project --prefer-dist cakephp/app davidcosta


### composer install
docker run -it --rm --volume $PWD:/app composer install --ignore-platform-reqs --no-scripts

