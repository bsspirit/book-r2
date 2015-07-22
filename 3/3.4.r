getwd()           # 当前的目录
list.dirs()

dir()
dir(path="/home/conan/R")
dir(path="/home/conan/R",pattern='^R')
dir(path="/home/conan/R",all.files=TRUE)

list.files()
list.files(".",all.files=TRUE)

file.info(".")
file.info("./tmp")

dir.create("create")
list.dirs()
# dir.create(path="a1/b2/c3")
dir.create(path="a1/b2/c3",recursive = TRUE)
list.dirs()
system("tree")

file.exists(".")
file.exists("./a1/b2")
file.exists("./aa")

df<-dir(full.names = TRUE)
file.access(df, 0) == 0
file.access(df, 1) == 0
file.access(df, 2) == 0
file.access(df, 4) == 0

Sys.chmod("./create", mode = "0555", use_umask = TRUE)
file.info("./create")
file.access(df, 2) == 0

file.rename("tmp", "tmp2")
dir()

unlink("tmp2", recursive = TRUE)
dir()

file.path("p1","p2","p3")
dir(file.path("a1","b2"))

getwd()
dirname("/home/conan/R/fs/readme.txt")
basename(getwd())
basename("/home/conan/R/fs/readme.txt")

path.expand("~/foo")
normalizePath(c(R.home(), tempdir()))
normalizePath(c(R.home(), tempdir()))
shortPathName(c(R.home(), tempdir()))


dir()
file.exists("readme.txt")
file.exists("readme.txt222")
file.info("readme.txt")
file.access("readme.txt",0)
file.access("readme.txt",1)
file.access("readme.txt",2)
file.access("readme.txt",4)
file.access("readme.txt222")

file_test("-d", "readme.txt")
file_test("-d", "create")
file_test("-f", "readme.txt")
file_test("-f", "create")

file.create("A.txt")
cat("file B\n", file = "B.txt")
dir()
readLines("A.txt")
readLines("B.txt")

file.append("A.txt", rep("B.txt", 10))
readLines("A.txt")
file.copy("A.txt", "C.txt")
readLines("C.txt")

Sys.chmod("A.txt", mode = "0700", use_umask = TRUE)
file.info("A.txt")

file.rename("A.txt","AA.txt")
dir()

file.link("readme.txt", "hard_link.txt")
file.symlink("readme.txt", "soft_link.txt")
system("ls -l")

file.remove("A.txt", "B.txt", "C.txt")
unlink("readme.txt")
system("ls -l")
readLines("hard_link.txt")
readLines("soft_link.txt")


R.home()
R.home(component="bin")
R.home(component="doc")
.Library
.Library.site
.libPaths()
system.file()
system.file(package = "pryr")


