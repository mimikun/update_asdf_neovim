today = $(shell date "+%Y%m%d")
product_name = update_asdf_neovim_nightly

.PHONY : patch
patch : clean diff-patch copy2win

.PHONY : format-patch
format-patch :
	git format-patch origin/master

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(command_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : clean
clean :
	rm -f *.patch

.PHONY : copy2win
copy2win :
	cp *.patch $$WIN_HOME/Downloads/
