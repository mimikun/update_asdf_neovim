function update_asdf_neovim_master --description 'Update asdf-neovim master'
    echo "Update neovim (latest)master!"
    asdf uninstall neovim ref:master
    asdf install neovim ref:master
end
