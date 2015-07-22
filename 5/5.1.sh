mkdir /home/conan/R/demo
cd /home/conan/R/demo
ls -l
ls -l sayHello
ls -l sayHello/man
ls -l sayHello/R

rm sayHello/Read-and-delete-me
rm sayHello/man/sayHello-package.Rd

R CMD build sayHello
R CMD INSTALL sayHello_1.0.tar.gz
ls /home/conan/R/x86_64-pc-linux-gnu-library/3.1

sudo apt-get install texlive-full
R CMD check sayHello_1.0.tar.gz

R CMD REMOVE sayHello
ls /home/conan/R/x86_64-pc-linux-gnu-library/3.1