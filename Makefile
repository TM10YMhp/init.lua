all:
	nvim -nu repro.lua

tags:
	# https://github.com/universal-ctags/ctags/issues/218#issuecomment-72355190
	rg --files | ctags -R --links=no -L -
