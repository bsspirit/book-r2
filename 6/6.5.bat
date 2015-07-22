updmap
initexmf --update-fndb
initexmf --edit-config-file updmap
initexmf --mkmaps

git clone https://github.com/bsspirit/gridgame.git
R CMD BUILD gridgame
R CMD INSTALL gridgame_*.tar.gz