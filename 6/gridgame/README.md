# gridgame

The R package **gridgame**. This package provides a general-purpose game framework for grid game in R. The package includes 2 games about snake and 2048. You can run the function snake() or g2048() to startup the game. These games are only running on **Window** platform.

[homepage](http://onbook.me/#/project/gridgame) for details and examples. See
[FAQ's](https://github.com/bsspirit/gridgame/wiki) for a list of
frequently asked questions (including where to ask questions).

## Installation

You can install the stable version on [CRAN](http://cran.r-project.org/package=gridgame):

```s
install.packages('gridgame')
```

Another way, You can also install from [RForge](http://rforge.net/gridgame/), which provides daily build of **gridgame**:

```s
# update all existing packages first
update.packages(ask = FALSE, repos = 'http://cran.rstudio.org')
install.packages('gridgame', repos = c('http://rforge.net', 'http://cran.rstudio.org'),type = 'source')
```

You can also install the development version from [Github](https://github.com/bsspirit/gridgame), which provides daily build of **gridgame**:

```s
library(devtools)
install_github("gridgame","bsspirit")
```

If you know GIT and `R CMD build`, it is handly way:

```bash
git clone https://github.com/bsspirit/gridgame.git
R CMD BUILD gridgame
R CMD INSTALL gridgame_*.tar.gz
```

## Usage

```s
library(gridgame)

# start snake game.
snake()

# start 2048 game. 
g2048()
```

## Document

+ R语言游戏之旅 贪食蛇入门 http://blog.fens.me/r-game-snake/
+ R语言游戏框架设计 http://blog.fens.me/r-game-framework/
+ R语言游戏之旅 游戏2048 http://blog.fens.me/r-game-2048/
+ 发布gridgame游戏包 http://blog.fens.me/r-game-gridgame/

## Screenshots

<img src="http://blog.fens.me/wp-content/uploads/2014/06/snake.gif" width="200px"/>
<img src="http://blog.fens.me/wp-content/uploads/2014/07/2048.gif" width="200px"/>


## License

This package is free and open source software, licensed under GPL-3.

