
docker run --rm --interactive --tty --volume $PWD:/app composer create-project --prefer-dist cakephp/app davidcosta

docker run -it --rm --volume $PWD:/app composer install --ignore-platform-reqs --no-scripts
docker build -t php-server .
docker run -d -p 80:80 -v $PWD:/var/www php-server
