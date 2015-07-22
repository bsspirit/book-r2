sudo apt-get install libcurl4-openssl-dev

mkdir -p /home/conan/R/chinaWeather/inst/tests

cd /home/conan/R/chinaWeather
git init
git add .
git commit -m 'init'
git remote add origin https://github.com/bsspirit/chinaWeather
git push -u origin master