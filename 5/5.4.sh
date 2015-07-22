cd /home/conan/R/chinaWeather
git branch app
git checkout app
git branch

mkdir /home/conan/R/chinaWeather/metadata
ls -l /home/conan/R/chinaWeather/metadata
ls -l /home/conan/R/chinaWeather/metadata/mapdata
mkdir /home/conan/R/chinaWeather/data

mkdir /home/conan/R/chinaWeather/dist
R CMD INSTALL dist/chinaWeather_0.1.tar.gz

git add .
git commit -m 'app
git push origin app